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
// Generated by CIRCT 30ab7a85a
module fpmult_loop_muladd_s3fdp(
  input              clk,
                     reset,
  input  [3:0][31:0] a,
                     b,
  input  [1:0][31:0] c,
  input              clk_0,
  output [31:0]      r
);

  wire [31:0]  _GEN;
  wire [31:0]  _GEN_0;
  wire         _GEN_1;
  wire [31:0]  _s3fdp_accum_r;
  wire [127:0] _GEN_2 = /*cast(bit[127:0])*/b;
  wire [127:0] _GEN_3 = /*cast(bit[127:0])*/a;
  reg  [31:0]  c_mem[0:1];
  always_ff @(posedge clk_0) begin
    if (reset) begin
    end
    else begin
      if (_GEN_1)
        c_mem[1'h0] <= _s3fdp_accum_r;
    end
  end // always_ff @(posedge)
  reg  [31:0]  _GEN_4;
  always_ff @(posedge clk_0) begin
    if (reset)
      _GEN_4 <= 32'h0;
    else
      _GEN_4 <= _GEN;
  end // always_ff @(posedge)
  assign _GEN_1 = _GEN_4 == 32'h0;
  reg  [31:0]  _GEN_5;
  always_ff @(posedge clk_0) begin
    if (reset)
      _GEN_5 <= 32'h0;
    else
      _GEN_5 <= _GEN_0;
  end // always_ff @(posedge)
  wire         _GEN_6 = _GEN_5 == 32'h3;
  assign _GEN_0 = _GEN_1 ? (_GEN_6 ? 32'h0 : _GEN_5 + 32'h1) : _GEN_5;
  reg          cg_en_latch;
  always @* begin
    if (~clk)
      cg_en_latch <= _GEN_1;
  end // always @*
  s3fdp_accum_core_wE8_wF23_cs16 s3fdp_accum (
    .clk   (clk & cg_en_latch),
    .reset (reset),
    .x
      (_GEN_5[1]
         ? (_GEN_5[0] ? _GEN_3[127:96] : _GEN_3[95:64])
         : _GEN_5[0] ? _GEN_3[63:32] : _GEN_3[31:0]),
    .y
      (_GEN_5[1]
         ? (_GEN_5[0] ? _GEN_2[127:96] : _GEN_2[95:64])
         : _GEN_5[0] ? _GEN_2[63:32] : _GEN_2[31:0]),
    .r     (_s3fdp_accum_r)
  );
  assign _GEN = _GEN_1 & _GEN_6 ? 32'h0 : _GEN_4;
  assign r = c_mem[1'h0];
endmodule

module s3fdp_accum_core_wE8_wF23_cs16(
  input         clk,
                reset,
  input  [31:0] x,
                y,
  output [31:0] r
);

  reg  [2:0]  _GEN;
  reg  [16:0] _GEN_0;
  reg         _GEN_1;
  wire        _GEN_2 = x[30:23] == 8'h0;
  wire        _GEN_3 = y[30:23] == 8'h0;
  wire        _GEN_4 = x[31] ^ y[31];
  wire [8:0]  _GEN_5 =
    {1'h0, _GEN_2 ? 8'h1 : x[30:23]} + {1'h0, _GEN_3 ? 8'h1 : y[30:23]} - 9'hF7;
  wire [64:0] _GEN_6 =
    _GEN_5[7] | _GEN_5[8]
      ? 65'h0
      : {17'h0, {48{_GEN_4}} ^ {24'h0, ~_GEN_2, x[22:0]} * {24'h0, ~_GEN_3, y[22:0]}};
  wire [64:0] _GEN_7 = _GEN_5[6] ? {_GEN_6[0], 64'h0} : _GEN_6;
  wire [48:0] _GEN_8 = _GEN_5[5] ? {_GEN_7[32:0], 16'h0} : _GEN_7[64:16];
  wire [32:0] _GEN_9 = _GEN_5[4] ? _GEN_8[32:0] : _GEN_8[48:16];
  wire [24:0] _GEN_10 = _GEN_5[3] ? _GEN_9[24:0] : _GEN_9[32:8];
  wire [20:0] _GEN_11 = _GEN_5[2] ? _GEN_10[20:0] : _GEN_10[24:4];
  wire [18:0] _GEN_12 = _GEN_5[1] ? _GEN_11[18:0] : _GEN_11[20:2];
  wire [17:0] _GEN_13 = _GEN_5[8] ? 18'h0 : _GEN_5[0] ? _GEN_12[17:0] : _GEN_12[18:1];
  always_ff @(posedge clk) begin
    if (reset)
      _GEN_1 <= 1'h0;
    else
      _GEN_1 <= $signed(_GEN_5) > 9'shC | (&(x[30:23])) | (&(y[30:23])) | _GEN_1;
  end // always_ff @(posedge)
  always_ff @(posedge clk) begin
    if (reset)
      _GEN_0 <= 17'h0;
    else
      _GEN_0 <= {1'h0, _GEN_0[15:0]} + {1'h0, _GEN_13[15:0]} + {16'h0, _GEN_4};
  end // always_ff @(posedge)
  always_ff @(posedge clk) begin
    if (reset)
      _GEN <= 3'h0;
    else
      _GEN <= {1'h0, _GEN[1:0]} + {1'h0, _GEN_13[17:16]} + {2'h0, _GEN_0[16]};
  end // always_ff @(posedge)
  wire [17:0] _GEN_14 = {_GEN[1:0], _GEN_0[15:0]} + {8'h0, _GEN_0[16], 9'h0};
  wire        _GEN_15 = _GEN_14 == 18'h0;
  wire [17:0] _GEN_16 = _GEN_14[17] ? ~_GEN_14 + 18'h1 : _GEN_14;
  wire        _GEN_17 = _GEN_16[17:2] == 16'h0;
  wire [14:0] _GEN_18 = _GEN_17 ? {_GEN_16[1:0], 13'h0} : _GEN_16[17:3];
  wire        _GEN_19 = _GEN_18[14:7] == 8'h0;
  wire [6:0]  _GEN_20 = _GEN_19 ? _GEN_18[6:0] : _GEN_18[14:8];
  wire        _GEN_21 = _GEN_20[6:3] == 4'h0;
  wire [2:0]  _GEN_22 = _GEN_21 ? _GEN_20[2:0] : _GEN_20[6:4];
  wire        _GEN_23 = _GEN_22[2:1] == 2'h0;
  wire        _GEN_24 = ~(_GEN_23 ? _GEN_22[0] : _GEN_22[2]);
  wire [16:0] _GEN_25 = _GEN_17 ? {_GEN_16[0], 16'h0} : _GEN_16[16:0];
  wire [16:0] _GEN_26 = _GEN_19 ? {_GEN_25[8:0], 8'h0} : _GEN_25;
  wire [16:0] _GEN_27 = _GEN_21 ? {_GEN_26[12:0], 4'h0} : _GEN_26;
  wire [16:0] _GEN_28 = _GEN_23 ? {_GEN_27[14:0], 2'h0} : _GEN_27;
  wire [9:0]  _GEN_29 =
    10'hB - {5'h0, _GEN_17, _GEN_19, _GEN_21, _GEN_23, _GEN_24} + 10'h7F;
  wire        _GEN_30 = $signed(_GEN_29) < 10'sh1;
  wire        _GEN_31 = $signed(_GEN_29) > 10'shFE;
  assign r =
    _GEN_1
      ? 32'h7FC00000
      : {_GEN_14[17],
         _GEN_31 ? 8'hFF : _GEN_30 | _GEN_15 ? 8'h0 : _GEN_29[7:0],
         _GEN_30 | _GEN_15 | _GEN_31
           ? 23'h0
           : {_GEN_24 ? {_GEN_28[15:0], 1'h0} : _GEN_28, 6'h0}};
endmodule

