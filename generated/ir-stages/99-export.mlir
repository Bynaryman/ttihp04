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
    %0 = sv.reg {hw.verilogName = "_GEN"} : !hw.inout<i11> 
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
    %c0_i265 = hw.constant 0 : i265
    %c0_i245 = hw.constant 0 : i245
    %c32704_i16 = hw.constant 32704 : i16
    %c1_i11 = hw.constant 1 : i11
    %c1_i2 = hw.constant 1 : i2
    %c0_i9 = hw.constant 0 : i9
    %c254_i11 = hw.constant 254 : i11
    %c0_i7 = hw.constant 0 : i7
    %c127_i11 = hw.constant 127 : i11
    %c132_i11 = hw.constant 132 : i11
    %c1_i266 = hw.constant 1 : i266
    %c-1_i266 = hw.constant -1 : i266
    %c0_i15 = hw.constant 0 : i15
    %c0_i11 = hw.constant 0 : i11
    %c0_i10 = hw.constant 0 : i10
    %c0_i17 = hw.constant 0 : i17
    %c0_i266 = hw.constant 0 : i266
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
    %55 = comb.concat %c0_i9, %54, %c0_i256 : i9, i16, i256
    %56 = sv.read_inout %48 : !hw.inout<i16>
    %57 = comb.concat %c0_i265, %56 : i265, i16
    %58 = comb.mux %53, %55, %57 : i281
    %59 = sv.wire {hw.verilogName = "_GEN_22"} : !hw.inout<i281>
    sv.assign %59, %58 : i281
    %60 = sv.read_inout %51 : !hw.inout<i9>
    %61 = comb.extract %60 from 7 : (i9) -> i1
    %62 = sv.read_inout %59 : !hw.inout<i281>
    %63 = comb.extract %62 from 0 : (i281) -> i153
    %64 = comb.concat %63, %c0_i128 : i153, i128
    %65 = sv.read_inout %59 : !hw.inout<i281>
    %66 = comb.mux %61, %64, %65 : i281
    %67 = sv.wire {hw.verilogName = "_GEN_23"} : !hw.inout<i281>
    sv.assign %67, %66 : i281
    %68 = sv.read_inout %51 : !hw.inout<i9>
    %69 = comb.extract %68 from 6 : (i9) -> i1
    %70 = sv.read_inout %67 : !hw.inout<i281>
    %71 = comb.extract %70 from 0 : (i281) -> i217
    %72 = comb.concat %71, %c0_i64 : i217, i64
    %73 = sv.read_inout %67 : !hw.inout<i281>
    %74 = comb.mux %69, %72, %73 : i281
    %75 = sv.wire {hw.verilogName = "_GEN_24"} : !hw.inout<i281>
    sv.assign %75, %74 : i281
    %76 = sv.read_inout %51 : !hw.inout<i9>
    %77 = comb.extract %76 from 5 : (i9) -> i1
    %78 = sv.read_inout %75 : !hw.inout<i281>
    %79 = comb.extract %78 from 0 : (i281) -> i249
    %80 = comb.concat %79, %c0_i32 : i249, i32
    %81 = sv.read_inout %75 : !hw.inout<i281>
    %82 = comb.mux %77, %80, %81 : i281
    %83 = sv.wire {hw.verilogName = "_GEN_25"} : !hw.inout<i281>
    sv.assign %83, %82 : i281
    %84 = sv.read_inout %51 : !hw.inout<i9>
    %85 = comb.extract %84 from 4 : (i9) -> i1
    %86 = sv.read_inout %83 : !hw.inout<i281>
    %87 = comb.extract %86 from 0 : (i281) -> i265
    %88 = comb.concat %87, %c0_i16 : i265, i16
    %89 = sv.read_inout %83 : !hw.inout<i281>
    %90 = comb.mux %85, %88, %89 : i281
    %91 = sv.wire {hw.verilogName = "_GEN_26"} : !hw.inout<i281>
    sv.assign %91, %90 : i281
    %92 = sv.read_inout %51 : !hw.inout<i9>
    %93 = comb.extract %92 from 3 : (i9) -> i1
    %94 = sv.read_inout %91 : !hw.inout<i281>
    %95 = comb.extract %94 from 0 : (i281) -> i273
    %96 = sv.read_inout %91 : !hw.inout<i281>
    %97 = comb.extract %96 from 8 : (i281) -> i273
    %98 = comb.mux %93, %95, %97 : i273
    %99 = sv.wire {hw.verilogName = "_GEN_27"} : !hw.inout<i273>
    sv.assign %99, %98 : i273
    %100 = sv.read_inout %51 : !hw.inout<i9>
    %101 = comb.extract %100 from 2 : (i9) -> i1
    %102 = sv.read_inout %99 : !hw.inout<i273>
    %103 = comb.extract %102 from 0 : (i273) -> i269
    %104 = sv.read_inout %99 : !hw.inout<i273>
    %105 = comb.extract %104 from 4 : (i273) -> i269
    %106 = comb.mux %101, %103, %105 : i269
    %107 = sv.wire {hw.verilogName = "_GEN_28"} : !hw.inout<i269>
    sv.assign %107, %106 : i269
    %108 = sv.read_inout %51 : !hw.inout<i9>
    %109 = comb.extract %108 from 1 : (i9) -> i1
    %110 = sv.read_inout %107 : !hw.inout<i269>
    %111 = comb.extract %110 from 0 : (i269) -> i267
    %112 = sv.read_inout %107 : !hw.inout<i269>
    %113 = comb.extract %112 from 2 : (i269) -> i267
    %114 = comb.mux %109, %111, %113 : i267
    %115 = sv.wire {hw.verilogName = "_GEN_29"} : !hw.inout<i267>
    sv.assign %115, %114 : i267
    %116 = sv.read_inout %51 : !hw.inout<i9>
    %117 = comb.extract %116 from 0 : (i9) -> i1
    %118 = sv.read_inout %115 : !hw.inout<i267>
    %119 = comb.extract %118 from 0 : (i267) -> i266
    %120 = sv.read_inout %115 : !hw.inout<i267>
    %121 = comb.extract %120 from 1 : (i267) -> i266
    %122 = comb.mux %117, %119, %121 : i266
    %123 = comb.mux %53, %c0_i266, %122 : i266
    %124 = sv.wire {hw.verilogName = "_GEN_30"} : !hw.inout<i266>
    sv.assign %124, %123 : i266
    %125 = sv.read_inout %17 : !hw.inout<i1>
    %126 = comb.or %33, %125 : i1
    %127 = comb.or %23, %126 : i1
    sv.alwaysff(posedge %clk) {
      sv.passign %17, %127 : i1
    }(syncreset : posedge %reset) {
      sv.passign %17, %false : i1
    }
    %128 = sv.read_inout %124 : !hw.inout<i266>
    %129 = comb.extract %128 from 0 : (i266) -> i16
    %130 = comb.concat %false, %129 : i1, i16
    %131 = sv.read_inout %39 : !hw.inout<i1>
    %132 = comb.concat %c0_i16, %131 : i16, i1
    %133 = sv.read_inout %16 : !hw.inout<i17>
    %134 = comb.extract %133 from 0 : (i17) -> i16
    %135 = comb.concat %false, %134 : i1, i16
    %136 = comb.add %130, %132 : i17
    %137 = comb.add %135, %136 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %16, %137 : i17
    }(syncreset : posedge %reset) {
      sv.passign %16, %c0_i17 : i17
    }
    %138 = sv.read_inout %16 : !hw.inout<i17>
    %139 = comb.extract %138 from 16 : (i17) -> i1
    %140 = sv.read_inout %124 : !hw.inout<i266>
    %141 = comb.extract %140 from 16 : (i266) -> i16
    %142 = comb.concat %false, %141 : i1, i16
    %143 = comb.concat %c0_i16, %139 : i16, i1
    %144 = sv.read_inout %15 : !hw.inout<i17>
    %145 = comb.extract %144 from 0 : (i17) -> i16
    %146 = comb.concat %false, %145 : i1, i16
    %147 = comb.add %142, %143 : i17
    %148 = comb.add %146, %147 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %15, %148 : i17
    }(syncreset : posedge %reset) {
      sv.passign %15, %c0_i17 : i17
    }
    %149 = sv.read_inout %15 : !hw.inout<i17>
    %150 = comb.extract %149 from 16 : (i17) -> i1
    %151 = sv.read_inout %124 : !hw.inout<i266>
    %152 = comb.extract %151 from 32 : (i266) -> i16
    %153 = comb.concat %false, %152 : i1, i16
    %154 = comb.concat %c0_i16, %150 : i16, i1
    %155 = sv.read_inout %14 : !hw.inout<i17>
    %156 = comb.extract %155 from 0 : (i17) -> i16
    %157 = comb.concat %false, %156 : i1, i16
    %158 = comb.add %153, %154 : i17
    %159 = comb.add %157, %158 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %14, %159 : i17
    }(syncreset : posedge %reset) {
      sv.passign %14, %c0_i17 : i17
    }
    %160 = sv.read_inout %14 : !hw.inout<i17>
    %161 = comb.extract %160 from 16 : (i17) -> i1
    %162 = sv.read_inout %124 : !hw.inout<i266>
    %163 = comb.extract %162 from 48 : (i266) -> i16
    %164 = comb.concat %false, %163 : i1, i16
    %165 = comb.concat %c0_i16, %161 : i16, i1
    %166 = sv.read_inout %13 : !hw.inout<i17>
    %167 = comb.extract %166 from 0 : (i17) -> i16
    %168 = comb.concat %false, %167 : i1, i16
    %169 = comb.add %164, %165 : i17
    %170 = comb.add %168, %169 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %13, %170 : i17
    }(syncreset : posedge %reset) {
      sv.passign %13, %c0_i17 : i17
    }
    %171 = sv.read_inout %13 : !hw.inout<i17>
    %172 = comb.extract %171 from 16 : (i17) -> i1
    %173 = sv.read_inout %124 : !hw.inout<i266>
    %174 = comb.extract %173 from 64 : (i266) -> i16
    %175 = comb.concat %false, %174 : i1, i16
    %176 = comb.concat %c0_i16, %172 : i16, i1
    %177 = sv.read_inout %12 : !hw.inout<i17>
    %178 = comb.extract %177 from 0 : (i17) -> i16
    %179 = comb.concat %false, %178 : i1, i16
    %180 = comb.add %175, %176 : i17
    %181 = comb.add %179, %180 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %12, %181 : i17
    }(syncreset : posedge %reset) {
      sv.passign %12, %c0_i17 : i17
    }
    %182 = sv.read_inout %12 : !hw.inout<i17>
    %183 = comb.extract %182 from 16 : (i17) -> i1
    %184 = sv.read_inout %124 : !hw.inout<i266>
    %185 = comb.extract %184 from 80 : (i266) -> i16
    %186 = comb.concat %false, %185 : i1, i16
    %187 = comb.concat %c0_i16, %183 : i16, i1
    %188 = sv.read_inout %11 : !hw.inout<i17>
    %189 = comb.extract %188 from 0 : (i17) -> i16
    %190 = comb.concat %false, %189 : i1, i16
    %191 = comb.add %186, %187 : i17
    %192 = comb.add %190, %191 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %11, %192 : i17
    }(syncreset : posedge %reset) {
      sv.passign %11, %c0_i17 : i17
    }
    %193 = sv.read_inout %11 : !hw.inout<i17>
    %194 = comb.extract %193 from 16 : (i17) -> i1
    %195 = sv.read_inout %124 : !hw.inout<i266>
    %196 = comb.extract %195 from 96 : (i266) -> i16
    %197 = comb.concat %false, %196 : i1, i16
    %198 = comb.concat %c0_i16, %194 : i16, i1
    %199 = sv.read_inout %10 : !hw.inout<i17>
    %200 = comb.extract %199 from 0 : (i17) -> i16
    %201 = comb.concat %false, %200 : i1, i16
    %202 = comb.add %197, %198 : i17
    %203 = comb.add %201, %202 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %10, %203 : i17
    }(syncreset : posedge %reset) {
      sv.passign %10, %c0_i17 : i17
    }
    %204 = sv.read_inout %10 : !hw.inout<i17>
    %205 = comb.extract %204 from 16 : (i17) -> i1
    %206 = sv.read_inout %124 : !hw.inout<i266>
    %207 = comb.extract %206 from 112 : (i266) -> i16
    %208 = comb.concat %false, %207 : i1, i16
    %209 = comb.concat %c0_i16, %205 : i16, i1
    %210 = sv.read_inout %9 : !hw.inout<i17>
    %211 = comb.extract %210 from 0 : (i17) -> i16
    %212 = comb.concat %false, %211 : i1, i16
    %213 = comb.add %208, %209 : i17
    %214 = comb.add %212, %213 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %9, %214 : i17
    }(syncreset : posedge %reset) {
      sv.passign %9, %c0_i17 : i17
    }
    %215 = sv.read_inout %9 : !hw.inout<i17>
    %216 = comb.extract %215 from 16 : (i17) -> i1
    %217 = sv.read_inout %124 : !hw.inout<i266>
    %218 = comb.extract %217 from 128 : (i266) -> i16
    %219 = comb.concat %false, %218 : i1, i16
    %220 = comb.concat %c0_i16, %216 : i16, i1
    %221 = sv.read_inout %8 : !hw.inout<i17>
    %222 = comb.extract %221 from 0 : (i17) -> i16
    %223 = comb.concat %false, %222 : i1, i16
    %224 = comb.add %219, %220 : i17
    %225 = comb.add %223, %224 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %8, %225 : i17
    }(syncreset : posedge %reset) {
      sv.passign %8, %c0_i17 : i17
    }
    %226 = sv.read_inout %8 : !hw.inout<i17>
    %227 = comb.extract %226 from 16 : (i17) -> i1
    %228 = sv.read_inout %124 : !hw.inout<i266>
    %229 = comb.extract %228 from 144 : (i266) -> i16
    %230 = comb.concat %false, %229 : i1, i16
    %231 = comb.concat %c0_i16, %227 : i16, i1
    %232 = sv.read_inout %7 : !hw.inout<i17>
    %233 = comb.extract %232 from 0 : (i17) -> i16
    %234 = comb.concat %false, %233 : i1, i16
    %235 = comb.add %230, %231 : i17
    %236 = comb.add %234, %235 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %7, %236 : i17
    }(syncreset : posedge %reset) {
      sv.passign %7, %c0_i17 : i17
    }
    %237 = sv.read_inout %7 : !hw.inout<i17>
    %238 = comb.extract %237 from 16 : (i17) -> i1
    %239 = sv.read_inout %124 : !hw.inout<i266>
    %240 = comb.extract %239 from 160 : (i266) -> i16
    %241 = comb.concat %false, %240 : i1, i16
    %242 = comb.concat %c0_i16, %238 : i16, i1
    %243 = sv.read_inout %6 : !hw.inout<i17>
    %244 = comb.extract %243 from 0 : (i17) -> i16
    %245 = comb.concat %false, %244 : i1, i16
    %246 = comb.add %241, %242 : i17
    %247 = comb.add %245, %246 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %6, %247 : i17
    }(syncreset : posedge %reset) {
      sv.passign %6, %c0_i17 : i17
    }
    %248 = sv.read_inout %6 : !hw.inout<i17>
    %249 = comb.extract %248 from 16 : (i17) -> i1
    %250 = sv.read_inout %124 : !hw.inout<i266>
    %251 = comb.extract %250 from 176 : (i266) -> i16
    %252 = comb.concat %false, %251 : i1, i16
    %253 = comb.concat %c0_i16, %249 : i16, i1
    %254 = sv.read_inout %5 : !hw.inout<i17>
    %255 = comb.extract %254 from 0 : (i17) -> i16
    %256 = comb.concat %false, %255 : i1, i16
    %257 = comb.add %252, %253 : i17
    %258 = comb.add %256, %257 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %5, %258 : i17
    }(syncreset : posedge %reset) {
      sv.passign %5, %c0_i17 : i17
    }
    %259 = sv.read_inout %5 : !hw.inout<i17>
    %260 = comb.extract %259 from 16 : (i17) -> i1
    %261 = sv.read_inout %124 : !hw.inout<i266>
    %262 = comb.extract %261 from 192 : (i266) -> i16
    %263 = comb.concat %false, %262 : i1, i16
    %264 = comb.concat %c0_i16, %260 : i16, i1
    %265 = sv.read_inout %4 : !hw.inout<i17>
    %266 = comb.extract %265 from 0 : (i17) -> i16
    %267 = comb.concat %false, %266 : i1, i16
    %268 = comb.add %263, %264 : i17
    %269 = comb.add %267, %268 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %4, %269 : i17
    }(syncreset : posedge %reset) {
      sv.passign %4, %c0_i17 : i17
    }
    %270 = sv.read_inout %4 : !hw.inout<i17>
    %271 = comb.extract %270 from 16 : (i17) -> i1
    %272 = sv.read_inout %124 : !hw.inout<i266>
    %273 = comb.extract %272 from 208 : (i266) -> i16
    %274 = comb.concat %false, %273 : i1, i16
    %275 = comb.concat %c0_i16, %271 : i16, i1
    %276 = sv.read_inout %3 : !hw.inout<i17>
    %277 = comb.extract %276 from 0 : (i17) -> i16
    %278 = comb.concat %false, %277 : i1, i16
    %279 = comb.add %274, %275 : i17
    %280 = comb.add %278, %279 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %3, %280 : i17
    }(syncreset : posedge %reset) {
      sv.passign %3, %c0_i17 : i17
    }
    %281 = sv.read_inout %3 : !hw.inout<i17>
    %282 = comb.extract %281 from 16 : (i17) -> i1
    %283 = sv.read_inout %124 : !hw.inout<i266>
    %284 = comb.extract %283 from 224 : (i266) -> i16
    %285 = comb.concat %false, %284 : i1, i16
    %286 = comb.concat %c0_i16, %282 : i16, i1
    %287 = sv.read_inout %2 : !hw.inout<i17>
    %288 = comb.extract %287 from 0 : (i17) -> i16
    %289 = comb.concat %false, %288 : i1, i16
    %290 = comb.add %285, %286 : i17
    %291 = comb.add %289, %290 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %2, %291 : i17
    }(syncreset : posedge %reset) {
      sv.passign %2, %c0_i17 : i17
    }
    %292 = sv.read_inout %2 : !hw.inout<i17>
    %293 = comb.extract %292 from 16 : (i17) -> i1
    %294 = sv.read_inout %124 : !hw.inout<i266>
    %295 = comb.extract %294 from 240 : (i266) -> i16
    %296 = comb.concat %false, %295 : i1, i16
    %297 = comb.concat %c0_i16, %293 : i16, i1
    %298 = sv.read_inout %1 : !hw.inout<i17>
    %299 = comb.extract %298 from 0 : (i17) -> i16
    %300 = comb.concat %false, %299 : i1, i16
    %301 = comb.add %296, %297 : i17
    %302 = comb.add %300, %301 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %1, %302 : i17
    }(syncreset : posedge %reset) {
      sv.passign %1, %c0_i17 : i17
    }
    %303 = sv.read_inout %1 : !hw.inout<i17>
    %304 = comb.extract %303 from 16 : (i17) -> i1
    %305 = sv.read_inout %124 : !hw.inout<i266>
    %306 = comb.extract %305 from 256 : (i266) -> i10
    %307 = comb.concat %false, %306 : i1, i10
    %308 = comb.concat %c0_i10, %304 : i10, i1
    %309 = sv.read_inout %0 : !hw.inout<i11>
    %310 = comb.extract %309 from 0 : (i11) -> i10
    %311 = comb.concat %false, %310 : i1, i10
    %312 = comb.add %307, %308 : i11
    %313 = comb.add %311, %312 : i11
    sv.alwaysff(posedge %clk) {
      sv.passign %0, %313 : i11
    }(syncreset : posedge %reset) {
      sv.passign %0, %c0_i11 : i11
    }
    %314 = comb.concat %310, %299, %288, %277, %266, %255, %244, %233, %222, %211, %200, %189, %178, %167, %156, %145, %134 : i10, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16
    %315 = comb.concat %c0_i9, %304, %c0_i15, %293, %c0_i15, %282, %c0_i15, %271, %c0_i15, %260, %c0_i15, %249, %c0_i15, %238, %c0_i15, %227, %c0_i15, %216, %c0_i15, %205, %c0_i15, %194, %c0_i15, %183, %c0_i15, %172, %c0_i15, %161, %c0_i15, %150, %c0_i15, %139, %c0_i16 : i9, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i16
    %316 = comb.add %314, %315 : i266
    %317 = sv.wire {hw.verilogName = "_GEN_31"} : !hw.inout<i266>
    sv.assign %317, %316 : i266
    %318 = sv.read_inout %317 : !hw.inout<i266>
    %319 = comb.icmp eq %318, %c0_i266 : i266
    %320 = sv.wire {hw.verilogName = "_GEN_32"} : !hw.inout<i1>
    sv.assign %320, %319 : i1
    %321 = sv.read_inout %317 : !hw.inout<i266>
    %322 = comb.extract %321 from 265 : (i266) -> i1
    %323 = sv.read_inout %317 : !hw.inout<i266>
    %324 = comb.xor %323, %c-1_i266 : i266
    %325 = comb.add %324, %c1_i266 : i266
    %326 = sv.read_inout %317 : !hw.inout<i266>
    %327 = comb.mux %322, %325, %326 : i266
    %328 = sv.wire {hw.verilogName = "_GEN_33"} : !hw.inout<i266>
    sv.assign %328, %327 : i266
    %329 = sv.read_inout %328 : !hw.inout<i266>
    %330 = comb.extract %329 from 10 : (i266) -> i256
    %331 = comb.icmp eq %330, %c0_i256 : i256
    %332 = sv.wire {hw.verilogName = "_GEN_34"} : !hw.inout<i1>
    sv.assign %332, %331 : i1
    %333 = sv.read_inout %328 : !hw.inout<i266>
    %334 = comb.extract %333 from 0 : (i266) -> i10
    %335 = comb.concat %334, %c0_i245 : i10, i245
    %336 = sv.read_inout %328 : !hw.inout<i266>
    %337 = comb.extract %336 from 11 : (i266) -> i255
    %338 = sv.read_inout %332 : !hw.inout<i1>
    %339 = comb.mux %338, %335, %337 : i255
    %340 = sv.wire {hw.verilogName = "_GEN_35"} : !hw.inout<i255>
    sv.assign %340, %339 : i255
    %341 = sv.read_inout %340 : !hw.inout<i255>
    %342 = comb.extract %341 from 127 : (i255) -> i128
    %343 = comb.icmp eq %342, %c0_i128 : i128
    %344 = sv.wire {hw.verilogName = "_GEN_36"} : !hw.inout<i1>
    sv.assign %344, %343 : i1
    %345 = sv.read_inout %340 : !hw.inout<i255>
    %346 = comb.extract %345 from 0 : (i255) -> i127
    %347 = sv.read_inout %340 : !hw.inout<i255>
    %348 = comb.extract %347 from 128 : (i255) -> i127
    %349 = sv.read_inout %344 : !hw.inout<i1>
    %350 = comb.mux %349, %346, %348 : i127
    %351 = sv.wire {hw.verilogName = "_GEN_37"} : !hw.inout<i127>
    sv.assign %351, %350 : i127
    %352 = sv.read_inout %351 : !hw.inout<i127>
    %353 = comb.extract %352 from 63 : (i127) -> i64
    %354 = comb.icmp eq %353, %c0_i64 : i64
    %355 = sv.wire {hw.verilogName = "_GEN_38"} : !hw.inout<i1>
    sv.assign %355, %354 : i1
    %356 = sv.read_inout %351 : !hw.inout<i127>
    %357 = comb.extract %356 from 0 : (i127) -> i63
    %358 = sv.read_inout %351 : !hw.inout<i127>
    %359 = comb.extract %358 from 64 : (i127) -> i63
    %360 = sv.read_inout %355 : !hw.inout<i1>
    %361 = comb.mux %360, %357, %359 : i63
    %362 = sv.wire {hw.verilogName = "_GEN_39"} : !hw.inout<i63>
    sv.assign %362, %361 : i63
    %363 = sv.read_inout %362 : !hw.inout<i63>
    %364 = comb.extract %363 from 31 : (i63) -> i32
    %365 = comb.icmp eq %364, %c0_i32 : i32
    %366 = sv.wire {hw.verilogName = "_GEN_40"} : !hw.inout<i1>
    sv.assign %366, %365 : i1
    %367 = sv.read_inout %362 : !hw.inout<i63>
    %368 = comb.extract %367 from 0 : (i63) -> i31
    %369 = sv.read_inout %362 : !hw.inout<i63>
    %370 = comb.extract %369 from 32 : (i63) -> i31
    %371 = sv.read_inout %366 : !hw.inout<i1>
    %372 = comb.mux %371, %368, %370 : i31
    %373 = sv.wire {hw.verilogName = "_GEN_41"} : !hw.inout<i31>
    sv.assign %373, %372 : i31
    %374 = sv.read_inout %373 : !hw.inout<i31>
    %375 = comb.extract %374 from 15 : (i31) -> i16
    %376 = comb.icmp eq %375, %c0_i16 : i16
    %377 = sv.wire {hw.verilogName = "_GEN_42"} : !hw.inout<i1>
    sv.assign %377, %376 : i1
    %378 = sv.read_inout %373 : !hw.inout<i31>
    %379 = comb.extract %378 from 0 : (i31) -> i15
    %380 = sv.read_inout %373 : !hw.inout<i31>
    %381 = comb.extract %380 from 16 : (i31) -> i15
    %382 = sv.read_inout %377 : !hw.inout<i1>
    %383 = comb.mux %382, %379, %381 : i15
    %384 = sv.wire {hw.verilogName = "_GEN_43"} : !hw.inout<i15>
    sv.assign %384, %383 : i15
    %385 = sv.read_inout %384 : !hw.inout<i15>
    %386 = comb.extract %385 from 7 : (i15) -> i8
    %387 = comb.icmp eq %386, %c0_i8 : i8
    %388 = sv.wire {hw.verilogName = "_GEN_44"} : !hw.inout<i1>
    sv.assign %388, %387 : i1
    %389 = sv.read_inout %384 : !hw.inout<i15>
    %390 = comb.extract %389 from 0 : (i15) -> i7
    %391 = sv.read_inout %384 : !hw.inout<i15>
    %392 = comb.extract %391 from 8 : (i15) -> i7
    %393 = sv.read_inout %388 : !hw.inout<i1>
    %394 = comb.mux %393, %390, %392 : i7
    %395 = sv.wire {hw.verilogName = "_GEN_45"} : !hw.inout<i7>
    sv.assign %395, %394 : i7
    %396 = sv.read_inout %395 : !hw.inout<i7>
    %397 = comb.extract %396 from 3 : (i7) -> i4
    %398 = comb.icmp eq %397, %c0_i4 : i4
    %399 = sv.wire {hw.verilogName = "_GEN_46"} : !hw.inout<i1>
    sv.assign %399, %398 : i1
    %400 = sv.read_inout %395 : !hw.inout<i7>
    %401 = comb.extract %400 from 0 : (i7) -> i3
    %402 = sv.read_inout %395 : !hw.inout<i7>
    %403 = comb.extract %402 from 4 : (i7) -> i3
    %404 = sv.read_inout %399 : !hw.inout<i1>
    %405 = comb.mux %404, %401, %403 : i3
    %406 = sv.wire {hw.verilogName = "_GEN_47"} : !hw.inout<i3>
    sv.assign %406, %405 : i3
    %407 = sv.read_inout %406 : !hw.inout<i3>
    %408 = comb.extract %407 from 1 : (i3) -> i2
    %409 = comb.icmp eq %408, %c0_i2 : i2
    %410 = sv.wire {hw.verilogName = "_GEN_48"} : !hw.inout<i1>
    sv.assign %410, %409 : i1
    %411 = sv.read_inout %406 : !hw.inout<i3>
    %412 = comb.extract %411 from 0 : (i3) -> i1
    %413 = sv.read_inout %406 : !hw.inout<i3>
    %414 = comb.extract %413 from 2 : (i3) -> i1
    %415 = sv.read_inout %410 : !hw.inout<i1>
    %416 = comb.mux %415, %412, %414 : i1
    %417 = comb.xor %416, %true : i1
    %418 = sv.wire {hw.verilogName = "_GEN_49"} : !hw.inout<i1>
    sv.assign %418, %417 : i1
    %419 = sv.read_inout %328 : !hw.inout<i266>
    %420 = comb.extract %419 from 0 : (i266) -> i9
    %421 = comb.concat %420, %c0_i256 : i9, i256
    %422 = sv.read_inout %328 : !hw.inout<i266>
    %423 = comb.extract %422 from 0 : (i266) -> i265
    %424 = sv.read_inout %332 : !hw.inout<i1>
    %425 = comb.mux %424, %421, %423 : i265
    %426 = sv.wire {hw.verilogName = "_GEN_50"} : !hw.inout<i265>
    sv.assign %426, %425 : i265
    %427 = sv.read_inout %426 : !hw.inout<i265>
    %428 = comb.extract %427 from 0 : (i265) -> i137
    %429 = comb.concat %428, %c0_i128 : i137, i128
    %430 = sv.read_inout %344 : !hw.inout<i1>
    %431 = sv.read_inout %426 : !hw.inout<i265>
    %432 = comb.mux %430, %429, %431 : i265
    %433 = sv.wire {hw.verilogName = "_GEN_51"} : !hw.inout<i265>
    sv.assign %433, %432 : i265
    %434 = sv.read_inout %433 : !hw.inout<i265>
    %435 = comb.extract %434 from 0 : (i265) -> i201
    %436 = comb.concat %435, %c0_i64 : i201, i64
    %437 = sv.read_inout %355 : !hw.inout<i1>
    %438 = sv.read_inout %433 : !hw.inout<i265>
    %439 = comb.mux %437, %436, %438 : i265
    %440 = sv.wire {hw.verilogName = "_GEN_52"} : !hw.inout<i265>
    sv.assign %440, %439 : i265
    %441 = sv.read_inout %440 : !hw.inout<i265>
    %442 = comb.extract %441 from 0 : (i265) -> i233
    %443 = comb.concat %442, %c0_i32 : i233, i32
    %444 = sv.read_inout %366 : !hw.inout<i1>
    %445 = sv.read_inout %440 : !hw.inout<i265>
    %446 = comb.mux %444, %443, %445 : i265
    %447 = sv.wire {hw.verilogName = "_GEN_53"} : !hw.inout<i265>
    sv.assign %447, %446 : i265
    %448 = sv.read_inout %447 : !hw.inout<i265>
    %449 = comb.extract %448 from 0 : (i265) -> i249
    %450 = comb.concat %449, %c0_i16 : i249, i16
    %451 = sv.read_inout %377 : !hw.inout<i1>
    %452 = sv.read_inout %447 : !hw.inout<i265>
    %453 = comb.mux %451, %450, %452 : i265
    %454 = sv.wire {hw.verilogName = "_GEN_54"} : !hw.inout<i265>
    sv.assign %454, %453 : i265
    %455 = sv.read_inout %454 : !hw.inout<i265>
    %456 = comb.extract %455 from 0 : (i265) -> i257
    %457 = comb.concat %456, %c0_i8 : i257, i8
    %458 = sv.read_inout %388 : !hw.inout<i1>
    %459 = sv.read_inout %454 : !hw.inout<i265>
    %460 = comb.mux %458, %457, %459 : i265
    %461 = sv.wire {hw.verilogName = "_GEN_55"} : !hw.inout<i265>
    sv.assign %461, %460 : i265
    %462 = sv.read_inout %461 : !hw.inout<i265>
    %463 = comb.extract %462 from 0 : (i265) -> i261
    %464 = comb.concat %463, %c0_i4 : i261, i4
    %465 = sv.read_inout %399 : !hw.inout<i1>
    %466 = sv.read_inout %461 : !hw.inout<i265>
    %467 = comb.mux %465, %464, %466 : i265
    %468 = sv.wire {hw.verilogName = "_GEN_56"} : !hw.inout<i265>
    sv.assign %468, %467 : i265
    %469 = sv.read_inout %468 : !hw.inout<i265>
    %470 = comb.extract %469 from 0 : (i265) -> i263
    %471 = comb.concat %470, %c0_i2 : i263, i2
    %472 = sv.read_inout %410 : !hw.inout<i1>
    %473 = sv.read_inout %468 : !hw.inout<i265>
    %474 = comb.mux %472, %471, %473 : i265
    %475 = sv.wire {hw.verilogName = "_GEN_57"} : !hw.inout<i265>
    sv.assign %475, %474 : i265
    %476 = sv.read_inout %475 : !hw.inout<i265>
    %477 = comb.extract %476 from 0 : (i265) -> i264
    %478 = comb.concat %477, %false : i264, i1
    %479 = sv.read_inout %418 : !hw.inout<i1>
    %480 = sv.read_inout %475 : !hw.inout<i265>
    %481 = comb.mux %479, %478, %480 : i265
    %482 = sv.wire {hw.verilogName = "_GEN_58"} : !hw.inout<i265>
    sv.assign %482, %481 : i265
    %483 = sv.read_inout %482 : !hw.inout<i265>
    %484 = comb.extract %483 from 0 : (i265) -> i256
    %485 = comb.icmp ne %484, %c0_i256 : i256
    %486 = sv.read_inout %332 : !hw.inout<i1>
    %487 = sv.read_inout %344 : !hw.inout<i1>
    %488 = sv.read_inout %355 : !hw.inout<i1>
    %489 = sv.read_inout %366 : !hw.inout<i1>
    %490 = sv.read_inout %377 : !hw.inout<i1>
    %491 = sv.read_inout %388 : !hw.inout<i1>
    %492 = sv.read_inout %399 : !hw.inout<i1>
    %493 = sv.read_inout %410 : !hw.inout<i1>
    %494 = sv.read_inout %418 : !hw.inout<i1>
    %495 = comb.concat %c0_i2, %486, %487, %488, %489, %490, %491, %492, %493, %494 : i2, i1, i1, i1, i1, i1, i1, i1, i1, i1
    %496 = comb.sub %c132_i11, %495 : i11
    %497 = sv.read_inout %482 : !hw.inout<i265>
    %498 = comb.extract %497 from 258 : (i265) -> i7
    %499 = sv.read_inout %482 : !hw.inout<i265>
    %500 = comb.extract %499 from 257 : (i265) -> i1
    %501 = sv.read_inout %482 : !hw.inout<i265>
    %502 = comb.extract %501 from 256 : (i265) -> i1
    %503 = sv.read_inout %482 : !hw.inout<i265>
    %504 = comb.extract %503 from 258 : (i265) -> i1
    %505 = comb.or %485, %504 : i1
    %506 = comb.or %502, %505 : i1
    %507 = comb.and %500, %506 : i1
    %508 = comb.concat %c0_i8, %507 : i8, i1
    %509 = comb.concat %c1_i2, %498 : i2, i7
    %510 = comb.add %509, %508 : i9
    %511 = sv.wire {hw.verilogName = "_GEN_59"} : !hw.inout<i9>
    sv.assign %511, %510 : i9
    %512 = sv.read_inout %511 : !hw.inout<i9>
    %513 = comb.extract %512 from 8 : (i9) -> i1
    %514 = sv.read_inout %511 : !hw.inout<i9>
    %515 = comb.extract %514 from 1 : (i9) -> i7
    %516 = sv.read_inout %511 : !hw.inout<i9>
    %517 = comb.extract %516 from 0 : (i9) -> i7
    %518 = comb.mux %513, %515, %517 : i7
    %519 = comb.concat %c0_i10, %513 : i10, i1
    %520 = comb.add %519, %c127_i11 : i11
    %521 = comb.add %496, %520 : i11
    %522 = sv.wire {hw.verilogName = "_GEN_60"} : !hw.inout<i11>
    sv.assign %522, %521 : i11
    %523 = sv.read_inout %522 : !hw.inout<i11>
    %524 = comb.icmp slt %523, %c1_i11 : i11
    %525 = sv.wire {hw.verilogName = "_GEN_61"} : !hw.inout<i1>
    sv.assign %525, %524 : i1
    %526 = sv.read_inout %522 : !hw.inout<i11>
    %527 = comb.icmp sgt %526, %c254_i11 : i11
    %528 = sv.wire {hw.verilogName = "_GEN_62"} : !hw.inout<i1>
    sv.assign %528, %527 : i1
    %529 = sv.read_inout %522 : !hw.inout<i11>
    %530 = comb.extract %529 from 0 : (i11) -> i8
    %531 = sv.read_inout %320 : !hw.inout<i1>
    %532 = sv.read_inout %525 : !hw.inout<i1>
    %533 = comb.or %532, %531 : i1
    %534 = comb.mux %533, %c0_i8, %530 : i8
    %535 = sv.read_inout %528 : !hw.inout<i1>
    %536 = comb.mux %535, %c-1_i8, %534 : i8
    %537 = sv.read_inout %320 : !hw.inout<i1>
    %538 = sv.read_inout %525 : !hw.inout<i1>
    %539 = sv.read_inout %528 : !hw.inout<i1>
    %540 = comb.or %537, %539 : i1
    %541 = comb.or %538, %540 : i1
    %542 = comb.mux %541, %c0_i7, %518 : i7
    %543 = comb.concat %322, %536, %542 : i1, i8, i7
    %544 = sv.read_inout %17 : !hw.inout<i1>
    %545 = comb.mux %544, %c32704_i16, %543 : i16
    hw.output %545 : i16
  }
}

