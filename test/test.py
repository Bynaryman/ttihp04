# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

FRAME_BYTES = 20
RUN_CYCLES = 3
OUT_BYTES = 4
COMPUTE_SLOT_BYTES = RUN_CYCLES + OUT_BYTES

# Small-loop protocol payload: a[2], b[2], c0
A_WORDS = [0x3F800000, 0x00000000]
B_WORDS = [0x3F800000, 0x00000000]
C0_WORD = 0x00000000
EXPECTED_WORD = 0x3F800000


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
    samples = []
    for byte in stream:
        dut.ui_in.value = byte
        await ClockCycles(dut.clk, 1)
        out_bin = str(dut.uo_out.value).lower()
        if "x" in out_bin or "z" in out_bin:
            samples.append(None)
        else:
            samples.append(int(dut.uo_out.value))
    return samples


def decode_le_word(samples: list[int | None], start: int) -> int | None:
    if start < 0 or start + 4 > len(samples):
        return None
    chunk = samples[start : start + 4]
    if any(byte is None for byte in chunk):
        return None
    assert all(byte is not None for byte in chunk)
    return chunk[0] | (chunk[1] << 8) | (chunk[2] << 16) | (chunk[3] << 24)


def find_expected_near(samples: list[int | None], nominal_start: int, expected: int) -> int | None:
    for offset in (-1, 0, 1):
        idx = nominal_start + offset
        word = decode_le_word(samples, idx)
        if word == expected:
            return idx
    return None


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
    samples = await stream_and_collect_words(dut, stream)

    # For this wrapper FSM, output bytes begin one cycle after ST_OUT entry.
    nominal_rel_start = FRAME_BYTES + RUN_CYCLES + 1
    frame0_start = 0
    frame1_start = FRAME_BYTES + COMPUTE_SLOT_BYTES
    hit0 = find_expected_near(samples, frame0_start + nominal_rel_start, EXPECTED_WORD)
    hit1 = find_expected_near(samples, frame1_start + nominal_rel_start, EXPECTED_WORD)

    assert hit0 is not None, "did not observe expected first output word near nominal window"
    assert hit1 is not None, "did not observe expected second output word near nominal window"

    dut._log.info("Found expected word at sample indexes: first=%d second=%d", hit0, hit1)
