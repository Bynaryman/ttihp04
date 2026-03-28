module attributes {circt.loweringOptions = "locationInfoStyle=none"} {
  hw.module @fpmult_loop_muladd_s3fdp(in %clk : i1 {hw.name = "clk"}, in %reset : i1 {hw.name = "reset"}, in %a : !hw.array<2xi16> {hw.name = "a"}, in %b : !hw.array<2xi16> {hw.name = "b"}, in %c : !hw.array<2xi16> {hw.name = "c"}, in %clk_0 : i1, out r : i16 {hw.name = "r"}) {
    %0 = sv.wire {hw.verilogName = "_GEN"} : !hw.inout<i32>
    %1 = sv.wire {hw.verilogName = "_GEN_0"} : !hw.inout<i32>
    %2 = sv.wire {hw.verilogName = "_GEN_1"} : !hw.inout<i1>
    %_s3fdp_accum_r = sv.wire {hw.verilogName = "_s3fdp_accum_r"} : !hw.inout<i16>
    %true = hw.constant true
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %3 = hw.bitcast %b : (!hw.array<2xi16>) -> i32
    %4 = sv.wire {hw.verilogName = "_GEN_2"} : !hw.inout<i32>
    sv.assign %4, %3 : i32
    %5 = hw.bitcast %a : (!hw.array<2xi16>) -> i32
    %6 = sv.wire {hw.verilogName = "_GEN_3"} : !hw.inout<i32>
    sv.assign %6, %5 : i32
    %c_mem = sv.reg {hw.verilogName = "c_mem"} : !hw.inout<uarray<2xi16>> 
    sv.alwaysff(posedge %clk_0) {
      %42 = sv.read_inout %2 : !hw.inout<i1>
      sv.if %42 {
        %43 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi16>>, i1
        %44 = sv.read_inout %_s3fdp_accum_r : !hw.inout<i16>
        sv.passign %43, %44 : i16
      }
    }(syncreset : posedge %reset) {
    }
    %7 = sv.reg {hw.verilogName = "_GEN_4"} : !hw.inout<i32> 
    sv.alwaysff(posedge %clk_0) {
      %42 = sv.read_inout %0 : !hw.inout<i32>
      sv.passign %7, %42 : i32
    }(syncreset : posedge %reset) {
      sv.passign %7, %c0_i32 : i32
    }
    %8 = sv.read_inout %7 : !hw.inout<i32>
    %9 = comb.icmp eq %8, %c0_i32 : i32
    sv.assign %2, %9 : i1
    %10 = sv.reg {hw.verilogName = "_GEN_5"} : !hw.inout<i32> 
    sv.alwaysff(posedge %clk_0) {
      %42 = sv.read_inout %1 : !hw.inout<i32>
      sv.passign %10, %42 : i32
    }(syncreset : posedge %reset) {
      sv.passign %10, %c0_i32 : i32
    }
    %11 = sv.read_inout %10 : !hw.inout<i32>
    %12 = comb.icmp eq %11, %c1_i32 : i32
    %13 = sv.wire {hw.verilogName = "_GEN_6"} : !hw.inout<i1>
    sv.assign %13, %12 : i1
    %14 = sv.read_inout %10 : !hw.inout<i32>
    %15 = comb.add %14, %c1_i32 : i32
    %16 = sv.read_inout %13 : !hw.inout<i1>
    %17 = comb.mux %16, %c0_i32, %15 : i32
    %18 = sv.read_inout %2 : !hw.inout<i1>
    %19 = sv.read_inout %10 : !hw.inout<i32>
    %20 = comb.mux %18, %17, %19 : i32
    sv.assign %1, %20 : i32
    %21 = sv.read_inout %2 : !hw.inout<i1>
    %22 = sv.read_inout %13 : !hw.inout<i1>
    %23 = comb.and %21, %22 : i1
    %24 = sv.read_inout %10 : !hw.inout<i32>
    %25 = comb.extract %24 from 0 : (i32) -> i1
    %26 = sv.read_inout %6 : !hw.inout<i32>
    %27 = comb.extract %26 from 0 : (i32) -> i16
    %28 = sv.read_inout %6 : !hw.inout<i32>
    %29 = comb.extract %28 from 16 : (i32) -> i16
    %30 = comb.mux %25, %29, %27 : i16
    %31 = sv.read_inout %4 : !hw.inout<i32>
    %32 = comb.extract %31 from 0 : (i32) -> i16
    %33 = sv.read_inout %4 : !hw.inout<i32>
    %34 = comb.extract %33 from 16 : (i32) -> i16
    %35 = comb.mux %25, %34, %32 : i16
    %cg_en_latch = sv.reg {hw.verilogName = "cg_en_latch"} : !hw.inout<i1> 
    sv.always  {
      %42 = comb.xor %clk, %true : i1
      sv.if %42 {
        %43 = sv.read_inout %2 : !hw.inout<i1>
        sv.passign %cg_en_latch, %43 : i1
      }
    }
    %36 = sv.read_inout %cg_en_latch : !hw.inout<i1>
    %37 = comb.and %clk, %36 : i1
    %s3fdp_accum.r = hw.instance "s3fdp_accum" @s3fdp_accum_core_wE8_wF7_cs16(clk: %37: i1, reset: %reset: i1, x: %30: i16, y: %35: i16) -> (r: i16) {hw.verilogName = "s3fdp_accum"}
    sv.assign %_s3fdp_accum_r, %s3fdp_accum.r : i16
    %38 = sv.read_inout %7 : !hw.inout<i32>
    %39 = comb.mux %23, %c0_i32, %38 : i32
    sv.assign %0, %39 : i32
    %40 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi16>>, i1
    %41 = sv.read_inout %40 : !hw.inout<i16>
    hw.output %41 : i16
  }
  hw.module @s3fdp_accum_core_wE8_wF7_cs16(in %clk : i1, in %reset : i1, in %x : i16, in %y : i16, out r : i16) {
    %0 = sv.reg {hw.verilogName = "_GEN"} : !hw.inout<i3> 
    %1 = sv.reg {hw.verilogName = "_GEN_0"} : !hw.inout<i17> 
    %2 = sv.reg {hw.verilogName = "_GEN_1"} : !hw.inout<i17> 
    %3 = sv.reg {hw.verilogName = "_GEN_2"} : !hw.inout<i17> 
    %4 = sv.reg {hw.verilogName = "_GEN_3"} : !hw.inout<i17> 
    %5 = sv.reg {hw.verilogName = "_GEN_4"} : !hw.inout<i17> 
    %6 = sv.reg {hw.verilogName = "_GEN_5"} : !hw.inout<i17> 
    %7 = sv.reg {hw.verilogName = "_GEN_6"} : !hw.inout<i17> 
    %8 = sv.reg {hw.verilogName = "_GEN_7"} : !hw.inout<i17> 
    %9 = sv.reg {hw.verilogName = "_GEN_8"} : !hw.inout<i17> 
    %10 = sv.reg {hw.verilogName = "_GEN_9"} : !hw.inout<i17> 
    %11 = sv.reg {hw.verilogName = "_GEN_10"} : !hw.inout<i17> 
    %12 = sv.reg {hw.verilogName = "_GEN_11"} : !hw.inout<i17> 
    %13 = sv.reg {hw.verilogName = "_GEN_12"} : !hw.inout<i17> 
    %14 = sv.reg {hw.verilogName = "_GEN_13"} : !hw.inout<i17> 
    %15 = sv.reg {hw.verilogName = "_GEN_14"} : !hw.inout<i17> 
    %16 = sv.reg {hw.verilogName = "_GEN_15"} : !hw.inout<i17> 
    %17 = sv.reg {hw.verilogName = "_GEN_16"} : !hw.inout<i1> 
    %c0_i257 = hw.constant 0 : i257
    %c0_i253 = hw.constant 0 : i253
    %c32704_i16 = hw.constant 32704 : i16
    %c1_i11 = hw.constant 1 : i11
    %c1_i2 = hw.constant 1 : i2
    %c254_i11 = hw.constant 254 : i11
    %c0_i7 = hw.constant 0 : i7
    %c0_i10 = hw.constant 0 : i10
    %c127_i11 = hw.constant 127 : i11
    %c124_i11 = hw.constant 124 : i11
    %c0_i248 = hw.constant 0 : i248
    %c1_i258 = hw.constant 1 : i258
    %c-1_i258 = hw.constant -1 : i258
    %c0_i15 = hw.constant 0 : i15
    %c0_i3 = hw.constant 0 : i3
    %c0_i17 = hw.constant 0 : i17
    %c0_i258 = hw.constant 0 : i258
    %c253_i9 = hw.constant 253 : i9
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %c0_i32 = hw.constant 0 : i32
    %c0_i64 = hw.constant 0 : i64
    %c0_i128 = hw.constant 0 : i128
    %c0_i256 = hw.constant 0 : i256
    %false = hw.constant false
    %c1_i8 = hw.constant 1 : i8
    %true = hw.constant true
    %c-1_i8 = hw.constant -1 : i8
    %c0_i8 = hw.constant 0 : i8
    %c0_i16 = hw.constant 0 : i16
    %18 = comb.extract %x from 15 : (i16) -> i1
    %19 = comb.extract %x from 7 : (i16) -> i8
    %20 = comb.extract %x from 0 : (i16) -> i7
    %21 = comb.icmp eq %19, %c0_i8 : i8
    %22 = sv.wire {hw.verilogName = "_GEN_17"} : !hw.inout<i1>
    sv.assign %22, %21 : i1
    %23 = comb.icmp eq %19, %c-1_i8 : i8
    %24 = sv.read_inout %22 : !hw.inout<i1>
    %25 = comb.xor %24, %true : i1
    %26 = sv.read_inout %22 : !hw.inout<i1>
    %27 = comb.mux %26, %c1_i8, %19 : i8
    %28 = comb.extract %y from 15 : (i16) -> i1
    %29 = comb.extract %y from 7 : (i16) -> i8
    %30 = comb.extract %y from 0 : (i16) -> i7
    %31 = comb.icmp eq %29, %c0_i8 : i8
    %32 = sv.wire {hw.verilogName = "_GEN_18"} : !hw.inout<i1>
    sv.assign %32, %31 : i1
    %33 = comb.icmp eq %29, %c-1_i8 : i8
    %34 = sv.read_inout %32 : !hw.inout<i1>
    %35 = comb.xor %34, %true : i1
    %36 = sv.read_inout %32 : !hw.inout<i1>
    %37 = comb.mux %36, %c1_i8, %29 : i8
    %38 = comb.xor %18, %28 : i1
    %39 = sv.wire {hw.verilogName = "_GEN_19"} : !hw.inout<i1>
    sv.assign %39, %38 : i1
    %40 = comb.concat %c0_i8, %25, %20 : i8, i1, i7
    %41 = comb.concat %c0_i8, %35, %30 : i8, i1, i7
    %42 = comb.mul %40, %41 : i16
    %43 = comb.concat %false, %37 : i1, i8
    %44 = comb.concat %false, %27 : i1, i8
    %45 = sv.read_inout %39 : !hw.inout<i1>
    %46 = comb.replicate %45 : (i1) -> i16
    %47 = comb.xor %46, %42 : i16
    %48 = sv.wire {hw.verilogName = "_GEN_20"} : !hw.inout<i16>
    sv.assign %48, %47 : i16
    %c120_i9 = hw.constant 120 : i9
    %49 = comb.sub %43, %c120_i9 : i9
    %50 = comb.add %44, %49 : i9
    %51 = sv.wire {hw.verilogName = "_GEN_21"} : !hw.inout<i9>
    sv.assign %51, %50 : i9
    %52 = sv.read_inout %51 : !hw.inout<i9>
    %53 = comb.extract %52 from 8 : (i9) -> i1
    %54 = sv.read_inout %48 : !hw.inout<i16>
    %55 = comb.concat %false, %54, %c0_i256 : i1, i16, i256
    %56 = sv.read_inout %48 : !hw.inout<i16>
    %57 = comb.concat %c0_i257, %56 : i257, i16
    %58 = comb.mux %53, %55, %57 : i273
    %59 = sv.wire {hw.verilogName = "_GEN_22"} : !hw.inout<i273>
    sv.assign %59, %58 : i273
    %60 = sv.read_inout %51 : !hw.inout<i9>
    %61 = comb.extract %60 from 7 : (i9) -> i1
    %62 = sv.read_inout %59 : !hw.inout<i273>
    %63 = comb.extract %62 from 0 : (i273) -> i145
    %64 = comb.concat %63, %c0_i128 : i145, i128
    %65 = sv.read_inout %59 : !hw.inout<i273>
    %66 = comb.mux %61, %64, %65 : i273
    %67 = sv.wire {hw.verilogName = "_GEN_23"} : !hw.inout<i273>
    sv.assign %67, %66 : i273
    %68 = sv.read_inout %51 : !hw.inout<i9>
    %69 = comb.extract %68 from 6 : (i9) -> i1
    %70 = sv.read_inout %67 : !hw.inout<i273>
    %71 = comb.extract %70 from 0 : (i273) -> i209
    %72 = comb.concat %71, %c0_i64 : i209, i64
    %73 = sv.read_inout %67 : !hw.inout<i273>
    %74 = comb.mux %69, %72, %73 : i273
    %75 = sv.wire {hw.verilogName = "_GEN_24"} : !hw.inout<i273>
    sv.assign %75, %74 : i273
    %76 = sv.read_inout %51 : !hw.inout<i9>
    %77 = comb.extract %76 from 5 : (i9) -> i1
    %78 = sv.read_inout %75 : !hw.inout<i273>
    %79 = comb.extract %78 from 0 : (i273) -> i241
    %80 = comb.concat %79, %c0_i32 : i241, i32
    %81 = sv.read_inout %75 : !hw.inout<i273>
    %82 = comb.mux %77, %80, %81 : i273
    %83 = sv.wire {hw.verilogName = "_GEN_25"} : !hw.inout<i273>
    sv.assign %83, %82 : i273
    %84 = sv.read_inout %51 : !hw.inout<i9>
    %85 = comb.extract %84 from 4 : (i9) -> i1
    %86 = sv.read_inout %83 : !hw.inout<i273>
    %87 = comb.extract %86 from 0 : (i273) -> i257
    %88 = comb.concat %87, %c0_i16 : i257, i16
    %89 = sv.read_inout %83 : !hw.inout<i273>
    %90 = comb.mux %85, %88, %89 : i273
    %91 = sv.wire {hw.verilogName = "_GEN_26"} : !hw.inout<i273>
    sv.assign %91, %90 : i273
    %92 = sv.read_inout %51 : !hw.inout<i9>
    %93 = comb.extract %92 from 3 : (i9) -> i1
    %94 = sv.read_inout %91 : !hw.inout<i273>
    %95 = comb.extract %94 from 0 : (i273) -> i265
    %96 = sv.read_inout %91 : !hw.inout<i273>
    %97 = comb.extract %96 from 8 : (i273) -> i265
    %98 = comb.mux %93, %95, %97 : i265
    %99 = sv.wire {hw.verilogName = "_GEN_27"} : !hw.inout<i265>
    sv.assign %99, %98 : i265
    %100 = sv.read_inout %51 : !hw.inout<i9>
    %101 = comb.extract %100 from 2 : (i9) -> i1
    %102 = sv.read_inout %99 : !hw.inout<i265>
    %103 = comb.extract %102 from 0 : (i265) -> i261
    %104 = sv.read_inout %99 : !hw.inout<i265>
    %105 = comb.extract %104 from 4 : (i265) -> i261
    %106 = comb.mux %101, %103, %105 : i261
    %107 = sv.wire {hw.verilogName = "_GEN_28"} : !hw.inout<i261>
    sv.assign %107, %106 : i261
    %108 = sv.read_inout %51 : !hw.inout<i9>
    %109 = comb.extract %108 from 1 : (i9) -> i1
    %110 = sv.read_inout %107 : !hw.inout<i261>
    %111 = comb.extract %110 from 0 : (i261) -> i259
    %112 = sv.read_inout %107 : !hw.inout<i261>
    %113 = comb.extract %112 from 2 : (i261) -> i259
    %114 = comb.mux %109, %111, %113 : i259
    %115 = sv.wire {hw.verilogName = "_GEN_29"} : !hw.inout<i259>
    sv.assign %115, %114 : i259
    %116 = sv.read_inout %51 : !hw.inout<i9>
    %117 = comb.extract %116 from 0 : (i9) -> i1
    %118 = sv.read_inout %115 : !hw.inout<i259>
    %119 = comb.extract %118 from 0 : (i259) -> i258
    %120 = sv.read_inout %115 : !hw.inout<i259>
    %121 = comb.extract %120 from 1 : (i259) -> i258
    %122 = comb.mux %117, %119, %121 : i258
    %123 = sv.read_inout %51 : !hw.inout<i9>
    %124 = comb.icmp sgt %123, %c253_i9 : i9
    %125 = comb.mux %53, %c0_i258, %122 : i258
    %126 = sv.wire {hw.verilogName = "_GEN_30"} : !hw.inout<i258>
    sv.assign %126, %125 : i258
    %127 = comb.or %124, %23 : i1
    %128 = sv.read_inout %17 : !hw.inout<i1>
    %129 = comb.or %33, %128 : i1
    %130 = comb.or %127, %129 : i1
    sv.alwaysff(posedge %clk) {
      sv.passign %17, %130 : i1
    }(syncreset : posedge %reset) {
      sv.passign %17, %false : i1
    }
    %131 = sv.read_inout %126 : !hw.inout<i258>
    %132 = comb.extract %131 from 0 : (i258) -> i16
    %133 = comb.concat %false, %132 : i1, i16
    %134 = sv.read_inout %39 : !hw.inout<i1>
    %135 = comb.concat %c0_i16, %134 : i16, i1
    %136 = sv.read_inout %16 : !hw.inout<i17>
    %137 = comb.extract %136 from 0 : (i17) -> i16
    %138 = comb.concat %false, %137 : i1, i16
    %139 = comb.add %133, %135 : i17
    %140 = comb.add %138, %139 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %16, %140 : i17
    }(syncreset : posedge %reset) {
      sv.passign %16, %c0_i17 : i17
    }
    %141 = sv.read_inout %16 : !hw.inout<i17>
    %142 = comb.extract %141 from 16 : (i17) -> i1
    %143 = sv.read_inout %126 : !hw.inout<i258>
    %144 = comb.extract %143 from 16 : (i258) -> i16
    %145 = comb.concat %false, %144 : i1, i16
    %146 = comb.concat %c0_i16, %142 : i16, i1
    %147 = sv.read_inout %15 : !hw.inout<i17>
    %148 = comb.extract %147 from 0 : (i17) -> i16
    %149 = comb.concat %false, %148 : i1, i16
    %150 = comb.add %145, %146 : i17
    %151 = comb.add %149, %150 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %15, %151 : i17
    }(syncreset : posedge %reset) {
      sv.passign %15, %c0_i17 : i17
    }
    %152 = sv.read_inout %15 : !hw.inout<i17>
    %153 = comb.extract %152 from 16 : (i17) -> i1
    %154 = sv.read_inout %126 : !hw.inout<i258>
    %155 = comb.extract %154 from 32 : (i258) -> i16
    %156 = comb.concat %false, %155 : i1, i16
    %157 = comb.concat %c0_i16, %153 : i16, i1
    %158 = sv.read_inout %14 : !hw.inout<i17>
    %159 = comb.extract %158 from 0 : (i17) -> i16
    %160 = comb.concat %false, %159 : i1, i16
    %161 = comb.add %156, %157 : i17
    %162 = comb.add %160, %161 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %14, %162 : i17
    }(syncreset : posedge %reset) {
      sv.passign %14, %c0_i17 : i17
    }
    %163 = sv.read_inout %14 : !hw.inout<i17>
    %164 = comb.extract %163 from 16 : (i17) -> i1
    %165 = sv.read_inout %126 : !hw.inout<i258>
    %166 = comb.extract %165 from 48 : (i258) -> i16
    %167 = comb.concat %false, %166 : i1, i16
    %168 = comb.concat %c0_i16, %164 : i16, i1
    %169 = sv.read_inout %13 : !hw.inout<i17>
    %170 = comb.extract %169 from 0 : (i17) -> i16
    %171 = comb.concat %false, %170 : i1, i16
    %172 = comb.add %167, %168 : i17
    %173 = comb.add %171, %172 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %13, %173 : i17
    }(syncreset : posedge %reset) {
      sv.passign %13, %c0_i17 : i17
    }
    %174 = sv.read_inout %13 : !hw.inout<i17>
    %175 = comb.extract %174 from 16 : (i17) -> i1
    %176 = sv.read_inout %126 : !hw.inout<i258>
    %177 = comb.extract %176 from 64 : (i258) -> i16
    %178 = comb.concat %false, %177 : i1, i16
    %179 = comb.concat %c0_i16, %175 : i16, i1
    %180 = sv.read_inout %12 : !hw.inout<i17>
    %181 = comb.extract %180 from 0 : (i17) -> i16
    %182 = comb.concat %false, %181 : i1, i16
    %183 = comb.add %178, %179 : i17
    %184 = comb.add %182, %183 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %12, %184 : i17
    }(syncreset : posedge %reset) {
      sv.passign %12, %c0_i17 : i17
    }
    %185 = sv.read_inout %12 : !hw.inout<i17>
    %186 = comb.extract %185 from 16 : (i17) -> i1
    %187 = sv.read_inout %126 : !hw.inout<i258>
    %188 = comb.extract %187 from 80 : (i258) -> i16
    %189 = comb.concat %false, %188 : i1, i16
    %190 = comb.concat %c0_i16, %186 : i16, i1
    %191 = sv.read_inout %11 : !hw.inout<i17>
    %192 = comb.extract %191 from 0 : (i17) -> i16
    %193 = comb.concat %false, %192 : i1, i16
    %194 = comb.add %189, %190 : i17
    %195 = comb.add %193, %194 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %11, %195 : i17
    }(syncreset : posedge %reset) {
      sv.passign %11, %c0_i17 : i17
    }
    %196 = sv.read_inout %11 : !hw.inout<i17>
    %197 = comb.extract %196 from 16 : (i17) -> i1
    %198 = sv.read_inout %126 : !hw.inout<i258>
    %199 = comb.extract %198 from 96 : (i258) -> i16
    %200 = comb.concat %false, %199 : i1, i16
    %201 = comb.concat %c0_i16, %197 : i16, i1
    %202 = sv.read_inout %10 : !hw.inout<i17>
    %203 = comb.extract %202 from 0 : (i17) -> i16
    %204 = comb.concat %false, %203 : i1, i16
    %205 = comb.add %200, %201 : i17
    %206 = comb.add %204, %205 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %10, %206 : i17
    }(syncreset : posedge %reset) {
      sv.passign %10, %c0_i17 : i17
    }
    %207 = sv.read_inout %10 : !hw.inout<i17>
    %208 = comb.extract %207 from 16 : (i17) -> i1
    %209 = sv.read_inout %126 : !hw.inout<i258>
    %210 = comb.extract %209 from 112 : (i258) -> i16
    %211 = comb.concat %false, %210 : i1, i16
    %212 = comb.concat %c0_i16, %208 : i16, i1
    %213 = sv.read_inout %9 : !hw.inout<i17>
    %214 = comb.extract %213 from 0 : (i17) -> i16
    %215 = comb.concat %false, %214 : i1, i16
    %216 = comb.add %211, %212 : i17
    %217 = comb.add %215, %216 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %9, %217 : i17
    }(syncreset : posedge %reset) {
      sv.passign %9, %c0_i17 : i17
    }
    %218 = sv.read_inout %9 : !hw.inout<i17>
    %219 = comb.extract %218 from 16 : (i17) -> i1
    %220 = sv.read_inout %126 : !hw.inout<i258>
    %221 = comb.extract %220 from 128 : (i258) -> i16
    %222 = comb.concat %false, %221 : i1, i16
    %223 = comb.concat %c0_i16, %219 : i16, i1
    %224 = sv.read_inout %8 : !hw.inout<i17>
    %225 = comb.extract %224 from 0 : (i17) -> i16
    %226 = comb.concat %false, %225 : i1, i16
    %227 = comb.add %222, %223 : i17
    %228 = comb.add %226, %227 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %8, %228 : i17
    }(syncreset : posedge %reset) {
      sv.passign %8, %c0_i17 : i17
    }
    %229 = sv.read_inout %8 : !hw.inout<i17>
    %230 = comb.extract %229 from 16 : (i17) -> i1
    %231 = sv.read_inout %126 : !hw.inout<i258>
    %232 = comb.extract %231 from 144 : (i258) -> i16
    %233 = comb.concat %false, %232 : i1, i16
    %234 = comb.concat %c0_i16, %230 : i16, i1
    %235 = sv.read_inout %7 : !hw.inout<i17>
    %236 = comb.extract %235 from 0 : (i17) -> i16
    %237 = comb.concat %false, %236 : i1, i16
    %238 = comb.add %233, %234 : i17
    %239 = comb.add %237, %238 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %7, %239 : i17
    }(syncreset : posedge %reset) {
      sv.passign %7, %c0_i17 : i17
    }
    %240 = sv.read_inout %7 : !hw.inout<i17>
    %241 = comb.extract %240 from 16 : (i17) -> i1
    %242 = sv.read_inout %126 : !hw.inout<i258>
    %243 = comb.extract %242 from 160 : (i258) -> i16
    %244 = comb.concat %false, %243 : i1, i16
    %245 = comb.concat %c0_i16, %241 : i16, i1
    %246 = sv.read_inout %6 : !hw.inout<i17>
    %247 = comb.extract %246 from 0 : (i17) -> i16
    %248 = comb.concat %false, %247 : i1, i16
    %249 = comb.add %244, %245 : i17
    %250 = comb.add %248, %249 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %6, %250 : i17
    }(syncreset : posedge %reset) {
      sv.passign %6, %c0_i17 : i17
    }
    %251 = sv.read_inout %6 : !hw.inout<i17>
    %252 = comb.extract %251 from 16 : (i17) -> i1
    %253 = sv.read_inout %126 : !hw.inout<i258>
    %254 = comb.extract %253 from 176 : (i258) -> i16
    %255 = comb.concat %false, %254 : i1, i16
    %256 = comb.concat %c0_i16, %252 : i16, i1
    %257 = sv.read_inout %5 : !hw.inout<i17>
    %258 = comb.extract %257 from 0 : (i17) -> i16
    %259 = comb.concat %false, %258 : i1, i16
    %260 = comb.add %255, %256 : i17
    %261 = comb.add %259, %260 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %5, %261 : i17
    }(syncreset : posedge %reset) {
      sv.passign %5, %c0_i17 : i17
    }
    %262 = sv.read_inout %5 : !hw.inout<i17>
    %263 = comb.extract %262 from 16 : (i17) -> i1
    %264 = sv.read_inout %126 : !hw.inout<i258>
    %265 = comb.extract %264 from 192 : (i258) -> i16
    %266 = comb.concat %false, %265 : i1, i16
    %267 = comb.concat %c0_i16, %263 : i16, i1
    %268 = sv.read_inout %4 : !hw.inout<i17>
    %269 = comb.extract %268 from 0 : (i17) -> i16
    %270 = comb.concat %false, %269 : i1, i16
    %271 = comb.add %266, %267 : i17
    %272 = comb.add %270, %271 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %4, %272 : i17
    }(syncreset : posedge %reset) {
      sv.passign %4, %c0_i17 : i17
    }
    %273 = sv.read_inout %4 : !hw.inout<i17>
    %274 = comb.extract %273 from 16 : (i17) -> i1
    %275 = sv.read_inout %126 : !hw.inout<i258>
    %276 = comb.extract %275 from 208 : (i258) -> i16
    %277 = comb.concat %false, %276 : i1, i16
    %278 = comb.concat %c0_i16, %274 : i16, i1
    %279 = sv.read_inout %3 : !hw.inout<i17>
    %280 = comb.extract %279 from 0 : (i17) -> i16
    %281 = comb.concat %false, %280 : i1, i16
    %282 = comb.add %277, %278 : i17
    %283 = comb.add %281, %282 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %3, %283 : i17
    }(syncreset : posedge %reset) {
      sv.passign %3, %c0_i17 : i17
    }
    %284 = sv.read_inout %3 : !hw.inout<i17>
    %285 = comb.extract %284 from 16 : (i17) -> i1
    %286 = sv.read_inout %126 : !hw.inout<i258>
    %287 = comb.extract %286 from 224 : (i258) -> i16
    %288 = comb.concat %false, %287 : i1, i16
    %289 = comb.concat %c0_i16, %285 : i16, i1
    %290 = sv.read_inout %2 : !hw.inout<i17>
    %291 = comb.extract %290 from 0 : (i17) -> i16
    %292 = comb.concat %false, %291 : i1, i16
    %293 = comb.add %288, %289 : i17
    %294 = comb.add %292, %293 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %2, %294 : i17
    }(syncreset : posedge %reset) {
      sv.passign %2, %c0_i17 : i17
    }
    %295 = sv.read_inout %2 : !hw.inout<i17>
    %296 = comb.extract %295 from 16 : (i17) -> i1
    %297 = sv.read_inout %126 : !hw.inout<i258>
    %298 = comb.extract %297 from 240 : (i258) -> i16
    %299 = comb.concat %false, %298 : i1, i16
    %300 = comb.concat %c0_i16, %296 : i16, i1
    %301 = sv.read_inout %1 : !hw.inout<i17>
    %302 = comb.extract %301 from 0 : (i17) -> i16
    %303 = comb.concat %false, %302 : i1, i16
    %304 = comb.add %299, %300 : i17
    %305 = comb.add %303, %304 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %1, %305 : i17
    }(syncreset : posedge %reset) {
      sv.passign %1, %c0_i17 : i17
    }
    %306 = sv.read_inout %1 : !hw.inout<i17>
    %307 = comb.extract %306 from 16 : (i17) -> i1
    %308 = sv.read_inout %126 : !hw.inout<i258>
    %309 = comb.extract %308 from 256 : (i258) -> i2
    %310 = comb.concat %false, %309 : i1, i2
    %311 = comb.concat %c0_i2, %307 : i2, i1
    %312 = sv.read_inout %0 : !hw.inout<i3>
    %313 = comb.extract %312 from 0 : (i3) -> i2
    %314 = comb.concat %false, %313 : i1, i2
    %315 = comb.add %310, %311 : i3
    %316 = comb.add %314, %315 : i3
    sv.alwaysff(posedge %clk) {
      sv.passign %0, %316 : i3
    }(syncreset : posedge %reset) {
      sv.passign %0, %c0_i3 : i3
    }
    %317 = comb.concat %313, %302, %291, %280, %269, %258, %247, %236, %225, %214, %203, %192, %181, %170, %159, %148, %137 : i2, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16
    %318 = comb.concat %false, %307, %c0_i15, %296, %c0_i15, %285, %c0_i15, %274, %c0_i15, %263, %c0_i15, %252, %c0_i15, %241, %c0_i15, %230, %c0_i15, %219, %c0_i15, %208, %c0_i15, %197, %c0_i15, %186, %c0_i15, %175, %c0_i15, %164, %c0_i15, %153, %c0_i15, %142, %c0_i16 : i1, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i16
    %319 = comb.add %317, %318 : i258
    %320 = sv.wire {hw.verilogName = "_GEN_31"} : !hw.inout<i258>
    sv.assign %320, %319 : i258
    %321 = sv.read_inout %320 : !hw.inout<i258>
    %322 = comb.icmp eq %321, %c0_i258 : i258
    %323 = sv.wire {hw.verilogName = "_GEN_32"} : !hw.inout<i1>
    sv.assign %323, %322 : i1
    %324 = sv.read_inout %320 : !hw.inout<i258>
    %325 = comb.extract %324 from 257 : (i258) -> i1
    %326 = sv.read_inout %320 : !hw.inout<i258>
    %327 = comb.xor %326, %c-1_i258 : i258
    %328 = comb.add %327, %c1_i258 : i258
    %329 = sv.read_inout %320 : !hw.inout<i258>
    %330 = comb.mux %325, %328, %329 : i258
    %331 = sv.wire {hw.verilogName = "_GEN_33"} : !hw.inout<i258>
    sv.assign %331, %330 : i258
    %332 = sv.read_inout %331 : !hw.inout<i258>
    %333 = comb.extract %332 from 2 : (i258) -> i256
    %334 = comb.icmp eq %333, %c0_i256 : i256
    %335 = sv.wire {hw.verilogName = "_GEN_34"} : !hw.inout<i1>
    sv.assign %335, %334 : i1
    %336 = sv.read_inout %331 : !hw.inout<i258>
    %337 = comb.extract %336 from 0 : (i258) -> i2
    %338 = comb.concat %337, %c0_i253 : i2, i253
    %339 = sv.read_inout %331 : !hw.inout<i258>
    %340 = comb.extract %339 from 3 : (i258) -> i255
    %341 = sv.read_inout %335 : !hw.inout<i1>
    %342 = comb.mux %341, %338, %340 : i255
    %343 = sv.wire {hw.verilogName = "_GEN_35"} : !hw.inout<i255>
    sv.assign %343, %342 : i255
    %344 = sv.read_inout %343 : !hw.inout<i255>
    %345 = comb.extract %344 from 127 : (i255) -> i128
    %346 = comb.icmp eq %345, %c0_i128 : i128
    %347 = sv.wire {hw.verilogName = "_GEN_36"} : !hw.inout<i1>
    sv.assign %347, %346 : i1
    %348 = sv.read_inout %343 : !hw.inout<i255>
    %349 = comb.extract %348 from 0 : (i255) -> i127
    %350 = sv.read_inout %343 : !hw.inout<i255>
    %351 = comb.extract %350 from 128 : (i255) -> i127
    %352 = sv.read_inout %347 : !hw.inout<i1>
    %353 = comb.mux %352, %349, %351 : i127
    %354 = sv.wire {hw.verilogName = "_GEN_37"} : !hw.inout<i127>
    sv.assign %354, %353 : i127
    %355 = sv.read_inout %354 : !hw.inout<i127>
    %356 = comb.extract %355 from 63 : (i127) -> i64
    %357 = comb.icmp eq %356, %c0_i64 : i64
    %358 = sv.wire {hw.verilogName = "_GEN_38"} : !hw.inout<i1>
    sv.assign %358, %357 : i1
    %359 = sv.read_inout %354 : !hw.inout<i127>
    %360 = comb.extract %359 from 0 : (i127) -> i63
    %361 = sv.read_inout %354 : !hw.inout<i127>
    %362 = comb.extract %361 from 64 : (i127) -> i63
    %363 = sv.read_inout %358 : !hw.inout<i1>
    %364 = comb.mux %363, %360, %362 : i63
    %365 = sv.wire {hw.verilogName = "_GEN_39"} : !hw.inout<i63>
    sv.assign %365, %364 : i63
    %366 = sv.read_inout %365 : !hw.inout<i63>
    %367 = comb.extract %366 from 31 : (i63) -> i32
    %368 = comb.icmp eq %367, %c0_i32 : i32
    %369 = sv.wire {hw.verilogName = "_GEN_40"} : !hw.inout<i1>
    sv.assign %369, %368 : i1
    %370 = sv.read_inout %365 : !hw.inout<i63>
    %371 = comb.extract %370 from 0 : (i63) -> i31
    %372 = sv.read_inout %365 : !hw.inout<i63>
    %373 = comb.extract %372 from 32 : (i63) -> i31
    %374 = sv.read_inout %369 : !hw.inout<i1>
    %375 = comb.mux %374, %371, %373 : i31
    %376 = sv.wire {hw.verilogName = "_GEN_41"} : !hw.inout<i31>
    sv.assign %376, %375 : i31
    %377 = sv.read_inout %376 : !hw.inout<i31>
    %378 = comb.extract %377 from 15 : (i31) -> i16
    %379 = comb.icmp eq %378, %c0_i16 : i16
    %380 = sv.wire {hw.verilogName = "_GEN_42"} : !hw.inout<i1>
    sv.assign %380, %379 : i1
    %381 = sv.read_inout %376 : !hw.inout<i31>
    %382 = comb.extract %381 from 0 : (i31) -> i15
    %383 = sv.read_inout %376 : !hw.inout<i31>
    %384 = comb.extract %383 from 16 : (i31) -> i15
    %385 = sv.read_inout %380 : !hw.inout<i1>
    %386 = comb.mux %385, %382, %384 : i15
    %387 = sv.wire {hw.verilogName = "_GEN_43"} : !hw.inout<i15>
    sv.assign %387, %386 : i15
    %388 = sv.read_inout %387 : !hw.inout<i15>
    %389 = comb.extract %388 from 7 : (i15) -> i8
    %390 = comb.icmp eq %389, %c0_i8 : i8
    %391 = sv.wire {hw.verilogName = "_GEN_44"} : !hw.inout<i1>
    sv.assign %391, %390 : i1
    %392 = sv.read_inout %387 : !hw.inout<i15>
    %393 = comb.extract %392 from 0 : (i15) -> i7
    %394 = sv.read_inout %387 : !hw.inout<i15>
    %395 = comb.extract %394 from 8 : (i15) -> i7
    %396 = sv.read_inout %391 : !hw.inout<i1>
    %397 = comb.mux %396, %393, %395 : i7
    %398 = sv.wire {hw.verilogName = "_GEN_45"} : !hw.inout<i7>
    sv.assign %398, %397 : i7
    %399 = sv.read_inout %398 : !hw.inout<i7>
    %400 = comb.extract %399 from 3 : (i7) -> i4
    %401 = comb.icmp eq %400, %c0_i4 : i4
    %402 = sv.wire {hw.verilogName = "_GEN_46"} : !hw.inout<i1>
    sv.assign %402, %401 : i1
    %403 = sv.read_inout %398 : !hw.inout<i7>
    %404 = comb.extract %403 from 0 : (i7) -> i3
    %405 = sv.read_inout %398 : !hw.inout<i7>
    %406 = comb.extract %405 from 4 : (i7) -> i3
    %407 = sv.read_inout %402 : !hw.inout<i1>
    %408 = comb.mux %407, %404, %406 : i3
    %409 = sv.wire {hw.verilogName = "_GEN_47"} : !hw.inout<i3>
    sv.assign %409, %408 : i3
    %410 = sv.read_inout %409 : !hw.inout<i3>
    %411 = comb.extract %410 from 1 : (i3) -> i2
    %412 = comb.icmp eq %411, %c0_i2 : i2
    %413 = sv.wire {hw.verilogName = "_GEN_48"} : !hw.inout<i1>
    sv.assign %413, %412 : i1
    %414 = sv.read_inout %409 : !hw.inout<i3>
    %415 = comb.extract %414 from 0 : (i3) -> i1
    %416 = sv.read_inout %409 : !hw.inout<i3>
    %417 = comb.extract %416 from 2 : (i3) -> i1
    %418 = sv.read_inout %413 : !hw.inout<i1>
    %419 = comb.mux %418, %415, %417 : i1
    %420 = comb.xor %419, %true : i1
    %421 = sv.wire {hw.verilogName = "_GEN_49"} : !hw.inout<i1>
    sv.assign %421, %420 : i1
    %422 = sv.read_inout %331 : !hw.inout<i258>
    %423 = comb.extract %422 from 0 : (i258) -> i1
    %424 = comb.concat %423, %c0_i256 : i1, i256
    %425 = sv.read_inout %331 : !hw.inout<i258>
    %426 = comb.extract %425 from 0 : (i258) -> i257
    %427 = sv.read_inout %335 : !hw.inout<i1>
    %428 = comb.mux %427, %424, %426 : i257
    %429 = sv.wire {hw.verilogName = "_GEN_50"} : !hw.inout<i257>
    sv.assign %429, %428 : i257
    %430 = sv.read_inout %429 : !hw.inout<i257>
    %431 = comb.extract %430 from 0 : (i257) -> i129
    %432 = comb.concat %431, %c0_i128 : i129, i128
    %433 = sv.read_inout %347 : !hw.inout<i1>
    %434 = sv.read_inout %429 : !hw.inout<i257>
    %435 = comb.mux %433, %432, %434 : i257
    %436 = sv.wire {hw.verilogName = "_GEN_51"} : !hw.inout<i257>
    sv.assign %436, %435 : i257
    %437 = sv.read_inout %436 : !hw.inout<i257>
    %438 = comb.extract %437 from 0 : (i257) -> i193
    %439 = comb.concat %438, %c0_i64 : i193, i64
    %440 = sv.read_inout %358 : !hw.inout<i1>
    %441 = sv.read_inout %436 : !hw.inout<i257>
    %442 = comb.mux %440, %439, %441 : i257
    %443 = sv.wire {hw.verilogName = "_GEN_52"} : !hw.inout<i257>
    sv.assign %443, %442 : i257
    %444 = sv.read_inout %443 : !hw.inout<i257>
    %445 = comb.extract %444 from 0 : (i257) -> i225
    %446 = comb.concat %445, %c0_i32 : i225, i32
    %447 = sv.read_inout %369 : !hw.inout<i1>
    %448 = sv.read_inout %443 : !hw.inout<i257>
    %449 = comb.mux %447, %446, %448 : i257
    %450 = sv.wire {hw.verilogName = "_GEN_53"} : !hw.inout<i257>
    sv.assign %450, %449 : i257
    %451 = sv.read_inout %450 : !hw.inout<i257>
    %452 = comb.extract %451 from 0 : (i257) -> i241
    %453 = comb.concat %452, %c0_i16 : i241, i16
    %454 = sv.read_inout %380 : !hw.inout<i1>
    %455 = sv.read_inout %450 : !hw.inout<i257>
    %456 = comb.mux %454, %453, %455 : i257
    %457 = sv.wire {hw.verilogName = "_GEN_54"} : !hw.inout<i257>
    sv.assign %457, %456 : i257
    %458 = sv.read_inout %457 : !hw.inout<i257>
    %459 = comb.extract %458 from 0 : (i257) -> i249
    %460 = comb.concat %459, %c0_i8 : i249, i8
    %461 = sv.read_inout %391 : !hw.inout<i1>
    %462 = sv.read_inout %457 : !hw.inout<i257>
    %463 = comb.mux %461, %460, %462 : i257
    %464 = sv.wire {hw.verilogName = "_GEN_55"} : !hw.inout<i257>
    sv.assign %464, %463 : i257
    %465 = sv.read_inout %464 : !hw.inout<i257>
    %466 = comb.extract %465 from 0 : (i257) -> i253
    %467 = comb.concat %466, %c0_i4 : i253, i4
    %468 = sv.read_inout %402 : !hw.inout<i1>
    %469 = sv.read_inout %464 : !hw.inout<i257>
    %470 = comb.mux %468, %467, %469 : i257
    %471 = sv.wire {hw.verilogName = "_GEN_56"} : !hw.inout<i257>
    sv.assign %471, %470 : i257
    %472 = sv.read_inout %471 : !hw.inout<i257>
    %473 = comb.extract %472 from 0 : (i257) -> i255
    %474 = comb.concat %473, %c0_i2 : i255, i2
    %475 = sv.read_inout %413 : !hw.inout<i1>
    %476 = sv.read_inout %471 : !hw.inout<i257>
    %477 = comb.mux %475, %474, %476 : i257
    %478 = sv.wire {hw.verilogName = "_GEN_57"} : !hw.inout<i257>
    sv.assign %478, %477 : i257
    %479 = sv.read_inout %478 : !hw.inout<i257>
    %480 = comb.extract %479 from 0 : (i257) -> i256
    %481 = comb.concat %480, %false : i256, i1
    %482 = sv.read_inout %421 : !hw.inout<i1>
    %483 = sv.read_inout %478 : !hw.inout<i257>
    %484 = comb.mux %482, %481, %483 : i257
    %485 = sv.wire {hw.verilogName = "_GEN_58"} : !hw.inout<i257>
    sv.assign %485, %484 : i257
    %486 = sv.read_inout %485 : !hw.inout<i257>
    %487 = comb.extract %486 from 0 : (i257) -> i248
    %488 = comb.icmp ne %487, %c0_i248 : i248
    %489 = sv.read_inout %335 : !hw.inout<i1>
    %490 = sv.read_inout %347 : !hw.inout<i1>
    %491 = sv.read_inout %358 : !hw.inout<i1>
    %492 = sv.read_inout %369 : !hw.inout<i1>
    %493 = sv.read_inout %380 : !hw.inout<i1>
    %494 = sv.read_inout %391 : !hw.inout<i1>
    %495 = sv.read_inout %402 : !hw.inout<i1>
    %496 = sv.read_inout %413 : !hw.inout<i1>
    %497 = sv.read_inout %421 : !hw.inout<i1>
    %498 = comb.concat %c0_i2, %489, %490, %491, %492, %493, %494, %495, %496, %497 : i2, i1, i1, i1, i1, i1, i1, i1, i1, i1
    %499 = comb.sub %c124_i11, %498 : i11
    %500 = sv.read_inout %485 : !hw.inout<i257>
    %501 = comb.extract %500 from 250 : (i257) -> i7
    %502 = sv.read_inout %485 : !hw.inout<i257>
    %503 = comb.extract %502 from 249 : (i257) -> i1
    %504 = sv.read_inout %485 : !hw.inout<i257>
    %505 = comb.extract %504 from 248 : (i257) -> i1
    %506 = sv.read_inout %485 : !hw.inout<i257>
    %507 = comb.extract %506 from 250 : (i257) -> i1
    %508 = comb.or %488, %507 : i1
    %509 = comb.or %505, %508 : i1
    %510 = comb.and %503, %509 : i1
    %511 = comb.concat %c0_i8, %510 : i8, i1
    %512 = comb.concat %c1_i2, %501 : i2, i7
    %513 = comb.add %512, %511 : i9
    %514 = sv.wire {hw.verilogName = "_GEN_59"} : !hw.inout<i9>
    sv.assign %514, %513 : i9
    %515 = sv.read_inout %514 : !hw.inout<i9>
    %516 = comb.extract %515 from 8 : (i9) -> i1
    %517 = sv.read_inout %514 : !hw.inout<i9>
    %518 = comb.extract %517 from 1 : (i9) -> i7
    %519 = sv.read_inout %514 : !hw.inout<i9>
    %520 = comb.extract %519 from 0 : (i9) -> i7
    %521 = comb.mux %516, %518, %520 : i7
    %522 = comb.concat %c0_i10, %516 : i10, i1
    %523 = comb.add %522, %c127_i11 : i11
    %524 = comb.add %499, %523 : i11
    %525 = sv.wire {hw.verilogName = "_GEN_60"} : !hw.inout<i11>
    sv.assign %525, %524 : i11
    %526 = sv.read_inout %525 : !hw.inout<i11>
    %527 = comb.icmp slt %526, %c1_i11 : i11
    %528 = sv.wire {hw.verilogName = "_GEN_61"} : !hw.inout<i1>
    sv.assign %528, %527 : i1
    %529 = sv.read_inout %525 : !hw.inout<i11>
    %530 = comb.icmp sgt %529, %c254_i11 : i11
    %531 = sv.wire {hw.verilogName = "_GEN_62"} : !hw.inout<i1>
    sv.assign %531, %530 : i1
    %532 = sv.read_inout %525 : !hw.inout<i11>
    %533 = comb.extract %532 from 0 : (i11) -> i8
    %534 = sv.read_inout %323 : !hw.inout<i1>
    %535 = sv.read_inout %528 : !hw.inout<i1>
    %536 = comb.or %535, %534 : i1
    %537 = comb.mux %536, %c0_i8, %533 : i8
    %538 = sv.read_inout %531 : !hw.inout<i1>
    %539 = comb.mux %538, %c-1_i8, %537 : i8
    %540 = sv.read_inout %323 : !hw.inout<i1>
    %541 = sv.read_inout %528 : !hw.inout<i1>
    %542 = sv.read_inout %531 : !hw.inout<i1>
    %543 = comb.or %540, %542 : i1
    %544 = comb.or %541, %543 : i1
    %545 = comb.mux %544, %c0_i7, %521 : i7
    %546 = comb.concat %325, %539, %545 : i1, i8, i7
    %547 = sv.read_inout %17 : !hw.inout<i1>
    %548 = comb.mux %547, %c32704_i16, %546 : i16
    hw.output %548 : i16
  }
}

