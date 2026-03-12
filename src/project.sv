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

  localparam int unsigned FRAME_BYTES = 36;
  localparam int unsigned RUN_LATENCY = 6;

  logic [1:0] state;
  logic [5:0] load_idx;
  logic [2:0] run_count;
  logic [1:0] out_idx;

  logic [31:0] a_words [0:3];
  logic [31:0] b_words [0:3];
  logic [31:0] c0_word;
  logic [31:0] result_word;

  logic [3:0][31:0] core_a;
  logic [3:0][31:0] core_b;
  logic [1:0][31:0] core_c;
  logic core_reset;
  logic [31:0] core_r;

  always @(*) begin
    core_a[0] = a_words[0];
    core_a[1] = a_words[1];
    core_a[2] = a_words[2];
    core_a[3] = a_words[3];
    core_b[0] = b_words[0];
    core_b[1] = b_words[1];
    core_b[2] = b_words[2];
    core_b[3] = b_words[3];
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
      a_words[2] <= '0;
      a_words[3] <= '0;
      b_words[0] <= '0;
      b_words[1] <= '0;
      b_words[2] <= '0;
      b_words[3] <= '0;
      c0_word <= '0;
      result_word <= '0;
    end else if (ena) begin
      case (state)
        ST_LOAD: begin
          case (load_idx)
            6'd0:  a_words[0][7:0]   <= ui_in;
            6'd1:  a_words[0][15:8]  <= ui_in;
            6'd2:  a_words[0][23:16] <= ui_in;
            6'd3:  a_words[0][31:24] <= ui_in;
            6'd4:  a_words[1][7:0]   <= ui_in;
            6'd5:  a_words[1][15:8]  <= ui_in;
            6'd6:  a_words[1][23:16] <= ui_in;
            6'd7:  a_words[1][31:24] <= ui_in;
            6'd8:  a_words[2][7:0]   <= ui_in;
            6'd9:  a_words[2][15:8]  <= ui_in;
            6'd10: a_words[2][23:16] <= ui_in;
            6'd11: a_words[2][31:24] <= ui_in;
            6'd12: a_words[3][7:0]   <= ui_in;
            6'd13: a_words[3][15:8]  <= ui_in;
            6'd14: a_words[3][23:16] <= ui_in;
            6'd15: a_words[3][31:24] <= ui_in;
            6'd16: b_words[0][7:0]   <= ui_in;
            6'd17: b_words[0][15:8]  <= ui_in;
            6'd18: b_words[0][23:16] <= ui_in;
            6'd19: b_words[0][31:24] <= ui_in;
            6'd20: b_words[1][7:0]   <= ui_in;
            6'd21: b_words[1][15:8]  <= ui_in;
            6'd22: b_words[1][23:16] <= ui_in;
            6'd23: b_words[1][31:24] <= ui_in;
            6'd24: b_words[2][7:0]   <= ui_in;
            6'd25: b_words[2][15:8]  <= ui_in;
            6'd26: b_words[2][23:16] <= ui_in;
            6'd27: b_words[2][31:24] <= ui_in;
            6'd28: b_words[3][7:0]   <= ui_in;
            6'd29: b_words[3][15:8]  <= ui_in;
            6'd30: b_words[3][23:16] <= ui_in;
            6'd31: b_words[3][31:24] <= ui_in;
            6'd32: c0_word[7:0]      <= ui_in;
            6'd33: c0_word[15:8]     <= ui_in;
            6'd34: c0_word[23:16]    <= ui_in;
            6'd35: c0_word[31:24]    <= ui_in;
            default: ;
          endcase

          if (load_idx == FRAME_BYTES - 1) begin
            state <= ST_RUN;
            run_count <= '0;
          end else begin
            load_idx <= load_idx + 6'd1;
          end
        end

        ST_RUN: begin
          if (run_count == RUN_LATENCY - 1) begin
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
            a_words[2] <= '0;
            a_words[3] <= '0;
            b_words[0] <= '0;
            b_words[1] <= '0;
            b_words[2] <= '0;
            b_words[3] <= '0;
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
