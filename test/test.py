# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

FRAME_BYTES = 36
COMPUTE_SLOT_BYTES = 10  # 6 run cycles + 4 output cycles
ST_OUT = 2

# Bounded vectors to avoid overflow with the narrow S3FDP specialization.
A_WORDS = [0x3F000000, 0x3E800000, 0x3E000000, 0x3D800000]  # 0.5, 0.25, 0.125, 0.0625
B_WORDS = [0x3F000000, 0x3F000000, 0x3F000000, 0x3F000000]  # 0.5 x4
C0_WORD = 0x00000000
EXPECTED_WORD = 0x3EF00000


def word_to_le_bytes(word: int) -> list[int]:
    return [(word >> shift) & 0xFF for shift in (0, 8, 16, 24)]


def build_frame() -> list[int]:
    payload = []
    for word in A_WORDS:
        payload.extend(word_to_le_bytes(word))
    for word in B_WORDS:
        payload.extend(word_to_le_bytes(word))
    payload.extend(word_to_le_bytes(C0_WORD))
    assert len(payload) == FRAME_BYTES
    return payload


async def stream_and_collect_words(dut, stream: list[int]) -> list[int]:
    words = []
    out_bytes = [0, 0, 0, 0]

    for byte in stream:
        dut.ui_in.value = byte
        await ClockCycles(dut.clk, 1)

        if int(dut.user_project.state.value) == ST_OUT:
            out_idx = int(dut.user_project.out_idx.value)
            out_bytes[out_idx] = int(dut.uo_out.value)
            if out_idx == 3:
                words.append(
                    out_bytes[0]
                    | (out_bytes[1] << 8)
                    | (out_bytes[2] << 16)
                    | (out_bytes[3] << 24)
                )

    return words


@cocotb.test()
async def test_streaming_s3fdp_wrapper(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    frame = build_frame()
    stream = frame + ([0] * COMPUTE_SLOT_BYTES) + frame + ([0] * COMPUTE_SLOT_BYTES)

    words = await stream_and_collect_words(dut, stream)
    dut._log.info("Captured words: %s", [f"0x{w:08x}" for w in words])

    assert len(words) >= 2, f"expected at least 2 output words, got {len(words)}"
    assert words[0] == EXPECTED_WORD, f"unexpected first result: 0x{words[0]:08x}"
    assert words[1] == EXPECTED_WORD, f"unexpected second result: 0x{words[1]:08x}"
