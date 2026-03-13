/*
 * Copyright (c) 2026 L. Ledoux
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_lledoux_s3fdp_seqcomb (
    input  wire [7:0] ui_in,
    output logic [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

  localparam logic [1:0] ST_LOAD = 2'd0;
  localparam logic [1:0] ST_RUN  = 2'd1;
  localparam logic [1:0] ST_OUT  = 2'd2;

  localparam logic [4:0] FRAME_LAST = 5'd19;
  localparam logic [2:0] RUN_LATENCY_CYCLES = 3'd3;

  logic [1:0] state;
  logic [4:0] load_idx;
  logic [2:0] run_count;
  logic [1:0] out_idx;

  logic [31:0] a_words [0:1];
  logic [31:0] b_words [0:1];
  logic [31:0] c0_word;
  logic [31:0] result_word;

  logic [1:0][31:0] core_a;
  logic [1:0][31:0] core_b;
  logic [1:0][31:0] core_c;
  logic core_reset;
  logic [31:0] core_r;

  always @(*) begin
    core_a[0] = a_words[0];
    core_a[1] = a_words[1];
    core_b[0] = b_words[0];
    core_b[1] = b_words[1];
    core_c[0] = c0_word;
    core_c[1] = 32'h00000000;
  end

  assign core_reset = (~rst_n) | (state == ST_LOAD);

  fpmult_loop_muladd_s3fdp s3fdp_core (
      .clk(clk),
      .reset(core_reset),
      .a(core_a),
      .b(core_b),
      .c(core_c),
      .clk_0(clk),
      .r(core_r)
  );

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state <= ST_LOAD;
      load_idx <= '0;
      run_count <= '0;
      out_idx <= '0;
      a_words[0] <= '0;
      a_words[1] <= '0;
      b_words[0] <= '0;
      b_words[1] <= '0;
      c0_word <= '0;
      result_word <= '0;
    end else if (ena) begin
      case (state)
        ST_LOAD: begin
          case (load_idx)
            5'd0:  a_words[0][7:0]   <= ui_in;
            5'd1:  a_words[0][15:8]  <= ui_in;
            5'd2:  a_words[0][23:16] <= ui_in;
            5'd3:  a_words[0][31:24] <= ui_in;
            5'd4:  a_words[1][7:0]   <= ui_in;
            5'd5:  a_words[1][15:8]  <= ui_in;
            5'd6:  a_words[1][23:16] <= ui_in;
            5'd7:  a_words[1][31:24] <= ui_in;
            5'd8:  b_words[0][7:0]   <= ui_in;
            5'd9:  b_words[0][15:8]  <= ui_in;
            5'd10: b_words[0][23:16] <= ui_in;
            5'd11: b_words[0][31:24] <= ui_in;
            5'd12: b_words[1][7:0]   <= ui_in;
            5'd13: b_words[1][15:8]  <= ui_in;
            5'd14: b_words[1][23:16] <= ui_in;
            5'd15: b_words[1][31:24] <= ui_in;
            5'd16: c0_word[7:0]      <= ui_in;
            5'd17: c0_word[15:8]     <= ui_in;
            5'd18: c0_word[23:16]    <= ui_in;
            5'd19: c0_word[31:24]    <= ui_in;
            default: ;
          endcase

          if (load_idx == FRAME_LAST) begin
            state <= ST_RUN;
            run_count <= '0;
          end else begin
            load_idx <= load_idx + 5'd1;
          end
        end

        ST_RUN: begin
          if (run_count == (RUN_LATENCY_CYCLES - 3'd1)) begin
            result_word <= core_r;
            state <= ST_OUT;
            out_idx <= '0;
          end else begin
            run_count <= run_count + 3'd1;
          end
        end

        ST_OUT: begin
          if (out_idx == 2'd3) begin
            state <= ST_LOAD;
            load_idx <= '0;
            a_words[0] <= '0;
            a_words[1] <= '0;
            b_words[0] <= '0;
            b_words[1] <= '0;
            c0_word <= '0;
          end else begin
            out_idx <= out_idx + 2'd1;
          end
        end

        default: begin
          state <= ST_LOAD;
          load_idx <= '0;
          run_count <= '0;
          out_idx <= '0;
        end
      endcase
    end
  end

  always @(*) begin
    if (state == ST_OUT) begin
      case (out_idx)
        2'd0: uo_out = result_word[7:0];
        2'd1: uo_out = result_word[15:8];
        2'd2: uo_out = result_word[23:16];
        2'd3: uo_out = result_word[31:24];
        default: uo_out = 8'h00;
      endcase
    end else begin
      uo_out = 8'h00;
    end
  end

  assign uio_out = 8'h00;
  assign uio_oe  = 8'h00;

  wire _unused = &{uio_in, 1'b0};

endmodule
