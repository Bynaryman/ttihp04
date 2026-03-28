module attributes {circt.loweringOptions = "locationInfoStyle=none"} {
  hw.module @fpmult_loop_muladd_s3fdp(in %clk : i1 {hw.name = "clk"}, in %reset : i1 {hw.name = "reset"}, in %a : !hw.array<2xi32> {hw.name = "a"}, in %b : !hw.array<2xi32> {hw.name = "b"}, in %c : !hw.array<2xi32> {hw.name = "c"}, in %clk_0 : i1, out r : i32 {hw.name = "r"}) {
    %0 = sv.wire {hw.verilogName = "_GEN"} : !hw.inout<i32>
    %1 = sv.wire {hw.verilogName = "_GEN_0"} : !hw.inout<i32>
    %2 = sv.wire {hw.verilogName = "_GEN_1"} : !hw.inout<i1>
    %_s3fdp_accum_r = sv.wire {hw.verilogName = "_s3fdp_accum_r"} : !hw.inout<i32>
    %true = hw.constant true
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %3 = hw.bitcast %b : (!hw.array<2xi32>) -> i64
    %4 = sv.wire {hw.verilogName = "_GEN_2"} : !hw.inout<i64>
    sv.assign %4, %3 : i64
    %5 = hw.bitcast %a : (!hw.array<2xi32>) -> i64
    %6 = sv.wire {hw.verilogName = "_GEN_3"} : !hw.inout<i64>
    sv.assign %6, %5 : i64
    %c_mem = sv.reg {hw.verilogName = "c_mem"} : !hw.inout<uarray<2xi32>> 
    sv.alwaysff(posedge %clk_0) {
      %42 = sv.read_inout %2 : !hw.inout<i1>
      sv.if %42 {
        %43 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi32>>, i1
        %44 = sv.read_inout %_s3fdp_accum_r : !hw.inout<i32>
        sv.passign %43, %44 : i32
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
    %26 = sv.read_inout %6 : !hw.inout<i64>
    %27 = comb.extract %26 from 0 : (i64) -> i32
    %28 = sv.read_inout %6 : !hw.inout<i64>
    %29 = comb.extract %28 from 32 : (i64) -> i32
    %30 = comb.mux %25, %29, %27 : i32
    %31 = sv.read_inout %4 : !hw.inout<i64>
    %32 = comb.extract %31 from 0 : (i64) -> i32
    %33 = sv.read_inout %4 : !hw.inout<i64>
    %34 = comb.extract %33 from 32 : (i64) -> i32
    %35 = comb.mux %25, %34, %32 : i32
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
    %s3fdp_accum.r = hw.instance "s3fdp_accum" @s3fdp_accum_core_wE8_wF23_cs16(clk: %37: i1, reset: %reset: i1, x: %30: i32, y: %35: i32) -> (r: i32) {hw.verilogName = "s3fdp_accum"}
    sv.assign %_s3fdp_accum_r, %s3fdp_accum.r : i32
    %38 = sv.read_inout %7 : !hw.inout<i32>
    %39 = comb.mux %23, %c0_i32, %38 : i32
    sv.assign %0, %39 : i32
    %40 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi32>>, i1
    %41 = sv.read_inout %40 : !hw.inout<i32>
    hw.output %41 : i32
  }
  hw.module @s3fdp_accum_core_wE8_wF23_cs16(in %clk : i1, in %reset : i1, in %x : i32, in %y : i32, out r : i32) {
    %0 = sv.reg {hw.verilogName = "_GEN"} : !hw.inout<i14> 
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
    %17 = sv.reg {hw.verilogName = "_GEN_16"} : !hw.inout<i17> 
    %18 = sv.reg {hw.verilogName = "_GEN_17"} : !hw.inout<i17> 
    %19 = sv.reg {hw.verilogName = "_GEN_18"} : !hw.inout<i17> 
    %20 = sv.reg {hw.verilogName = "_GEN_19"} : !hw.inout<i17> 
    %21 = sv.reg {hw.verilogName = "_GEN_20"} : !hw.inout<i17> 
    %22 = sv.reg {hw.verilogName = "_GEN_21"} : !hw.inout<i17> 
    %23 = sv.reg {hw.verilogName = "_GEN_22"} : !hw.inout<i17> 
    %24 = sv.reg {hw.verilogName = "_GEN_23"} : !hw.inout<i17> 
    %25 = sv.reg {hw.verilogName = "_GEN_24"} : !hw.inout<i17> 
    %26 = sv.reg {hw.verilogName = "_GEN_25"} : !hw.inout<i17> 
    %27 = sv.reg {hw.verilogName = "_GEN_26"} : !hw.inout<i17> 
    %28 = sv.reg {hw.verilogName = "_GEN_27"} : !hw.inout<i17> 
    %29 = sv.reg {hw.verilogName = "_GEN_28"} : !hw.inout<i17> 
    %30 = sv.reg {hw.verilogName = "_GEN_29"} : !hw.inout<i17> 
    %31 = sv.reg {hw.verilogName = "_GEN_30"} : !hw.inout<i17> 
    %32 = sv.reg {hw.verilogName = "_GEN_31"} : !hw.inout<i17> 
    %33 = sv.reg {hw.verilogName = "_GEN_32"} : !hw.inout<i17> 
    %34 = sv.reg {hw.verilogName = "_GEN_33"} : !hw.inout<i17> 
    %35 = sv.reg {hw.verilogName = "_GEN_34"} : !hw.inout<i1> 
    %c0_i466 = hw.constant 0 : i466
    %c2143289344_i32 = hw.constant 2143289344 : i32
    %c1_i12 = hw.constant 1 : i12
    %c1_i2 = hw.constant 1 : i2
    %c0_i12 = hw.constant 0 : i12
    %c0_i255 = hw.constant 0 : i255
    %c254_i12 = hw.constant 254 : i12
    %c0_i23 = hw.constant 0 : i23
    %c0_i11 = hw.constant 0 : i11
    %c127_i12 = hw.constant 127 : i12
    %c258_i12 = hw.constant 258 : i12
    %c0_i531 = hw.constant 0 : i531
    %c0_i512 = hw.constant 0 : i512
    %c1_i557 = hw.constant 1 : i557
    %c-1_i557 = hw.constant -1 : i557
    %c0_i15 = hw.constant 0 : i15
    %c0_i14 = hw.constant 0 : i14
    %c0_i13 = hw.constant 0 : i13
    %c0_i17 = hw.constant 0 : i17
    %c0_i557 = hw.constant 0 : i557
    %c40_i9 = hw.constant 40 : i9
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %c0_i16 = hw.constant 0 : i16
    %c0_i64 = hw.constant 0 : i64
    %c0_i128 = hw.constant 0 : i128
    %c0_i256 = hw.constant 0 : i256
    %c0_i511 = hw.constant 0 : i511
    %c45_i9 = hw.constant 45 : i9
    %c0_i24 = hw.constant 0 : i24
    %false = hw.constant false
    %c1_i8 = hw.constant 1 : i8
    %true = hw.constant true
    %c-1_i8 = hw.constant -1 : i8
    %c0_i8 = hw.constant 0 : i8
    %c0_i32 = hw.constant 0 : i32
    %36 = comb.extract %x from 31 : (i32) -> i1
    %37 = comb.extract %x from 23 : (i32) -> i8
    %38 = comb.extract %x from 0 : (i32) -> i23
    %39 = comb.icmp eq %37, %c0_i8 : i8
    %40 = sv.wire {hw.verilogName = "_GEN_35"} : !hw.inout<i1>
    sv.assign %40, %39 : i1
    %41 = comb.icmp eq %37, %c-1_i8 : i8
    %42 = sv.read_inout %40 : !hw.inout<i1>
    %43 = comb.xor %42, %true : i1
    %44 = sv.read_inout %40 : !hw.inout<i1>
    %45 = comb.mux %44, %c1_i8, %37 : i8
    %46 = comb.extract %y from 31 : (i32) -> i1
    %47 = comb.extract %y from 23 : (i32) -> i8
    %48 = comb.extract %y from 0 : (i32) -> i23
    %49 = comb.icmp eq %47, %c0_i8 : i8
    %50 = sv.wire {hw.verilogName = "_GEN_36"} : !hw.inout<i1>
    sv.assign %50, %49 : i1
    %51 = comb.icmp eq %47, %c-1_i8 : i8
    %52 = sv.read_inout %50 : !hw.inout<i1>
    %53 = comb.xor %52, %true : i1
    %54 = sv.read_inout %50 : !hw.inout<i1>
    %55 = comb.mux %54, %c1_i8, %47 : i8
    %56 = comb.xor %36, %46 : i1
    %57 = sv.wire {hw.verilogName = "_GEN_37"} : !hw.inout<i1>
    sv.assign %57, %56 : i1
    %58 = comb.concat %c0_i24, %43, %38 : i24, i1, i23
    %59 = comb.concat %c0_i24, %53, %48 : i24, i1, i23
    %60 = comb.mul %58, %59 : i48
    %61 = comb.concat %false, %55 : i1, i8
    %62 = comb.concat %false, %45 : i1, i8
    %63 = sv.read_inout %57 : !hw.inout<i1>
    %64 = comb.replicate %63 : (i1) -> i48
    %65 = comb.xor %64, %60 : i48
    %66 = sv.wire {hw.verilogName = "_GEN_38"} : !hw.inout<i48>
    sv.assign %66, %65 : i48
    %67 = comb.add %61, %c45_i9 : i9
    %68 = comb.add %62, %67 : i9
    %69 = sv.wire {hw.verilogName = "_GEN_39"} : !hw.inout<i9>
    sv.assign %69, %68 : i9
    %70 = sv.read_inout %66 : !hw.inout<i48>
    %71 = comb.concat %c0_i511, %70 : i511, i48
    %72 = sv.read_inout %69 : !hw.inout<i9>
    %73 = comb.extract %72 from 8 : (i9) -> i1
    %74 = sv.read_inout %66 : !hw.inout<i48>
    %75 = comb.concat %c0_i255, %74, %c0_i256 : i255, i48, i256
    %76 = comb.mux %73, %75, %71 : i559
    %77 = sv.wire {hw.verilogName = "_GEN_40"} : !hw.inout<i559>
    sv.assign %77, %76 : i559
    %78 = sv.read_inout %69 : !hw.inout<i9>
    %79 = comb.extract %78 from 7 : (i9) -> i1
    %80 = sv.read_inout %77 : !hw.inout<i559>
    %81 = comb.extract %80 from 0 : (i559) -> i431
    %82 = comb.concat %81, %c0_i128 : i431, i128
    %83 = sv.read_inout %77 : !hw.inout<i559>
    %84 = comb.mux %79, %82, %83 : i559
    %85 = sv.wire {hw.verilogName = "_GEN_41"} : !hw.inout<i559>
    sv.assign %85, %84 : i559
    %86 = sv.read_inout %69 : !hw.inout<i9>
    %87 = comb.extract %86 from 6 : (i9) -> i1
    %88 = sv.read_inout %85 : !hw.inout<i559>
    %89 = comb.extract %88 from 0 : (i559) -> i495
    %90 = comb.concat %89, %c0_i64 : i495, i64
    %91 = sv.read_inout %85 : !hw.inout<i559>
    %92 = comb.mux %87, %90, %91 : i559
    %93 = sv.wire {hw.verilogName = "_GEN_42"} : !hw.inout<i559>
    sv.assign %93, %92 : i559
    %94 = sv.read_inout %69 : !hw.inout<i9>
    %95 = comb.extract %94 from 5 : (i9) -> i1
    %96 = sv.read_inout %93 : !hw.inout<i559>
    %97 = comb.extract %96 from 0 : (i559) -> i527
    %98 = comb.concat %97, %c0_i16 : i527, i16
    %99 = sv.read_inout %93 : !hw.inout<i559>
    %100 = comb.extract %99 from 16 : (i559) -> i543
    %101 = comb.mux %95, %98, %100 : i543
    %102 = sv.wire {hw.verilogName = "_GEN_43"} : !hw.inout<i543>
    sv.assign %102, %101 : i543
    %103 = sv.read_inout %69 : !hw.inout<i9>
    %104 = comb.extract %103 from 4 : (i9) -> i1
    %105 = sv.read_inout %102 : !hw.inout<i543>
    %106 = comb.extract %105 from 0 : (i543) -> i527
    %107 = sv.read_inout %102 : !hw.inout<i543>
    %108 = comb.extract %107 from 16 : (i543) -> i527
    %109 = comb.mux %104, %106, %108 : i527
    %110 = sv.wire {hw.verilogName = "_GEN_44"} : !hw.inout<i527>
    sv.assign %110, %109 : i527
    %111 = sv.read_inout %69 : !hw.inout<i9>
    %112 = comb.extract %111 from 3 : (i9) -> i1
    %113 = sv.read_inout %110 : !hw.inout<i527>
    %114 = comb.extract %113 from 0 : (i527) -> i519
    %115 = sv.read_inout %110 : !hw.inout<i527>
    %116 = comb.extract %115 from 8 : (i527) -> i519
    %117 = comb.mux %112, %114, %116 : i519
    %118 = sv.wire {hw.verilogName = "_GEN_45"} : !hw.inout<i519>
    sv.assign %118, %117 : i519
    %119 = sv.read_inout %69 : !hw.inout<i9>
    %120 = comb.extract %119 from 2 : (i9) -> i1
    %121 = sv.read_inout %118 : !hw.inout<i519>
    %122 = comb.extract %121 from 0 : (i519) -> i515
    %123 = sv.read_inout %118 : !hw.inout<i519>
    %124 = comb.extract %123 from 4 : (i519) -> i515
    %125 = comb.mux %120, %122, %124 : i515
    %126 = sv.wire {hw.verilogName = "_GEN_46"} : !hw.inout<i515>
    sv.assign %126, %125 : i515
    %127 = sv.read_inout %69 : !hw.inout<i9>
    %128 = comb.extract %127 from 1 : (i9) -> i1
    %129 = sv.read_inout %126 : !hw.inout<i515>
    %130 = comb.extract %129 from 0 : (i515) -> i513
    %131 = sv.read_inout %126 : !hw.inout<i515>
    %132 = comb.extract %131 from 2 : (i515) -> i513
    %133 = comb.mux %128, %130, %132 : i513
    %134 = sv.wire {hw.verilogName = "_GEN_47"} : !hw.inout<i513>
    sv.assign %134, %133 : i513
    %135 = sv.read_inout %69 : !hw.inout<i9>
    %136 = comb.extract %135 from 0 : (i9) -> i1
    %137 = sv.read_inout %134 : !hw.inout<i513>
    %138 = comb.extract %137 from 0 : (i513) -> i512
    %139 = sv.read_inout %134 : !hw.inout<i513>
    %140 = comb.extract %139 from 1 : (i513) -> i512
    %141 = comb.mux %136, %138, %140 : i512
    %142 = sv.read_inout %69 : !hw.inout<i9>
    %143 = comb.icmp sgt %142, %c40_i9 : i9
    %144 = sv.read_inout %57 : !hw.inout<i1>
    %145 = comb.replicate %144 : (i1) -> i45
    %146 = comb.concat %145, %141 : i45, i512
    %147 = comb.mux %73, %c0_i557, %146 : i557
    %148 = sv.wire {hw.verilogName = "_GEN_48"} : !hw.inout<i557>
    sv.assign %148, %147 : i557
    %149 = comb.or %143, %41 : i1
    %150 = sv.read_inout %35 : !hw.inout<i1>
    %151 = comb.or %51, %150 : i1
    %152 = comb.or %149, %151 : i1
    sv.alwaysff(posedge %clk) {
      sv.passign %35, %152 : i1
    }(syncreset : posedge %reset) {
      sv.passign %35, %false : i1
    }
    %153 = sv.read_inout %148 : !hw.inout<i557>
    %154 = comb.extract %153 from 0 : (i557) -> i16
    %155 = comb.concat %false, %154 : i1, i16
    %156 = sv.read_inout %57 : !hw.inout<i1>
    %157 = comb.concat %c0_i16, %156 : i16, i1
    %158 = sv.read_inout %34 : !hw.inout<i17>
    %159 = comb.extract %158 from 0 : (i17) -> i16
    %160 = comb.concat %false, %159 : i1, i16
    %161 = comb.add %155, %157 : i17
    %162 = comb.add %160, %161 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %34, %162 : i17
    }(syncreset : posedge %reset) {
      sv.passign %34, %c0_i17 : i17
    }
    %163 = sv.read_inout %34 : !hw.inout<i17>
    %164 = comb.extract %163 from 16 : (i17) -> i1
    %165 = sv.read_inout %148 : !hw.inout<i557>
    %166 = comb.extract %165 from 16 : (i557) -> i16
    %167 = comb.concat %false, %166 : i1, i16
    %168 = comb.concat %c0_i16, %164 : i16, i1
    %169 = sv.read_inout %33 : !hw.inout<i17>
    %170 = comb.extract %169 from 0 : (i17) -> i16
    %171 = comb.concat %false, %170 : i1, i16
    %172 = comb.add %167, %168 : i17
    %173 = comb.add %171, %172 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %33, %173 : i17
    }(syncreset : posedge %reset) {
      sv.passign %33, %c0_i17 : i17
    }
    %174 = sv.read_inout %33 : !hw.inout<i17>
    %175 = comb.extract %174 from 16 : (i17) -> i1
    %176 = sv.read_inout %148 : !hw.inout<i557>
    %177 = comb.extract %176 from 32 : (i557) -> i16
    %178 = comb.concat %false, %177 : i1, i16
    %179 = comb.concat %c0_i16, %175 : i16, i1
    %180 = sv.read_inout %32 : !hw.inout<i17>
    %181 = comb.extract %180 from 0 : (i17) -> i16
    %182 = comb.concat %false, %181 : i1, i16
    %183 = comb.add %178, %179 : i17
    %184 = comb.add %182, %183 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %32, %184 : i17
    }(syncreset : posedge %reset) {
      sv.passign %32, %c0_i17 : i17
    }
    %185 = sv.read_inout %32 : !hw.inout<i17>
    %186 = comb.extract %185 from 16 : (i17) -> i1
    %187 = sv.read_inout %148 : !hw.inout<i557>
    %188 = comb.extract %187 from 48 : (i557) -> i16
    %189 = comb.concat %false, %188 : i1, i16
    %190 = comb.concat %c0_i16, %186 : i16, i1
    %191 = sv.read_inout %31 : !hw.inout<i17>
    %192 = comb.extract %191 from 0 : (i17) -> i16
    %193 = comb.concat %false, %192 : i1, i16
    %194 = comb.add %189, %190 : i17
    %195 = comb.add %193, %194 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %31, %195 : i17
    }(syncreset : posedge %reset) {
      sv.passign %31, %c0_i17 : i17
    }
    %196 = sv.read_inout %31 : !hw.inout<i17>
    %197 = comb.extract %196 from 16 : (i17) -> i1
    %198 = sv.read_inout %148 : !hw.inout<i557>
    %199 = comb.extract %198 from 64 : (i557) -> i16
    %200 = comb.concat %false, %199 : i1, i16
    %201 = comb.concat %c0_i16, %197 : i16, i1
    %202 = sv.read_inout %30 : !hw.inout<i17>
    %203 = comb.extract %202 from 0 : (i17) -> i16
    %204 = comb.concat %false, %203 : i1, i16
    %205 = comb.add %200, %201 : i17
    %206 = comb.add %204, %205 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %30, %206 : i17
    }(syncreset : posedge %reset) {
      sv.passign %30, %c0_i17 : i17
    }
    %207 = sv.read_inout %30 : !hw.inout<i17>
    %208 = comb.extract %207 from 16 : (i17) -> i1
    %209 = sv.read_inout %148 : !hw.inout<i557>
    %210 = comb.extract %209 from 80 : (i557) -> i16
    %211 = comb.concat %false, %210 : i1, i16
    %212 = comb.concat %c0_i16, %208 : i16, i1
    %213 = sv.read_inout %29 : !hw.inout<i17>
    %214 = comb.extract %213 from 0 : (i17) -> i16
    %215 = comb.concat %false, %214 : i1, i16
    %216 = comb.add %211, %212 : i17
    %217 = comb.add %215, %216 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %29, %217 : i17
    }(syncreset : posedge %reset) {
      sv.passign %29, %c0_i17 : i17
    }
    %218 = sv.read_inout %29 : !hw.inout<i17>
    %219 = comb.extract %218 from 16 : (i17) -> i1
    %220 = sv.read_inout %148 : !hw.inout<i557>
    %221 = comb.extract %220 from 96 : (i557) -> i16
    %222 = comb.concat %false, %221 : i1, i16
    %223 = comb.concat %c0_i16, %219 : i16, i1
    %224 = sv.read_inout %28 : !hw.inout<i17>
    %225 = comb.extract %224 from 0 : (i17) -> i16
    %226 = comb.concat %false, %225 : i1, i16
    %227 = comb.add %222, %223 : i17
    %228 = comb.add %226, %227 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %28, %228 : i17
    }(syncreset : posedge %reset) {
      sv.passign %28, %c0_i17 : i17
    }
    %229 = sv.read_inout %28 : !hw.inout<i17>
    %230 = comb.extract %229 from 16 : (i17) -> i1
    %231 = sv.read_inout %148 : !hw.inout<i557>
    %232 = comb.extract %231 from 112 : (i557) -> i16
    %233 = comb.concat %false, %232 : i1, i16
    %234 = comb.concat %c0_i16, %230 : i16, i1
    %235 = sv.read_inout %27 : !hw.inout<i17>
    %236 = comb.extract %235 from 0 : (i17) -> i16
    %237 = comb.concat %false, %236 : i1, i16
    %238 = comb.add %233, %234 : i17
    %239 = comb.add %237, %238 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %27, %239 : i17
    }(syncreset : posedge %reset) {
      sv.passign %27, %c0_i17 : i17
    }
    %240 = sv.read_inout %27 : !hw.inout<i17>
    %241 = comb.extract %240 from 16 : (i17) -> i1
    %242 = sv.read_inout %148 : !hw.inout<i557>
    %243 = comb.extract %242 from 128 : (i557) -> i16
    %244 = comb.concat %false, %243 : i1, i16
    %245 = comb.concat %c0_i16, %241 : i16, i1
    %246 = sv.read_inout %26 : !hw.inout<i17>
    %247 = comb.extract %246 from 0 : (i17) -> i16
    %248 = comb.concat %false, %247 : i1, i16
    %249 = comb.add %244, %245 : i17
    %250 = comb.add %248, %249 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %26, %250 : i17
    }(syncreset : posedge %reset) {
      sv.passign %26, %c0_i17 : i17
    }
    %251 = sv.read_inout %26 : !hw.inout<i17>
    %252 = comb.extract %251 from 16 : (i17) -> i1
    %253 = sv.read_inout %148 : !hw.inout<i557>
    %254 = comb.extract %253 from 144 : (i557) -> i16
    %255 = comb.concat %false, %254 : i1, i16
    %256 = comb.concat %c0_i16, %252 : i16, i1
    %257 = sv.read_inout %25 : !hw.inout<i17>
    %258 = comb.extract %257 from 0 : (i17) -> i16
    %259 = comb.concat %false, %258 : i1, i16
    %260 = comb.add %255, %256 : i17
    %261 = comb.add %259, %260 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %25, %261 : i17
    }(syncreset : posedge %reset) {
      sv.passign %25, %c0_i17 : i17
    }
    %262 = sv.read_inout %25 : !hw.inout<i17>
    %263 = comb.extract %262 from 16 : (i17) -> i1
    %264 = sv.read_inout %148 : !hw.inout<i557>
    %265 = comb.extract %264 from 160 : (i557) -> i16
    %266 = comb.concat %false, %265 : i1, i16
    %267 = comb.concat %c0_i16, %263 : i16, i1
    %268 = sv.read_inout %24 : !hw.inout<i17>
    %269 = comb.extract %268 from 0 : (i17) -> i16
    %270 = comb.concat %false, %269 : i1, i16
    %271 = comb.add %266, %267 : i17
    %272 = comb.add %270, %271 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %24, %272 : i17
    }(syncreset : posedge %reset) {
      sv.passign %24, %c0_i17 : i17
    }
    %273 = sv.read_inout %24 : !hw.inout<i17>
    %274 = comb.extract %273 from 16 : (i17) -> i1
    %275 = sv.read_inout %148 : !hw.inout<i557>
    %276 = comb.extract %275 from 176 : (i557) -> i16
    %277 = comb.concat %false, %276 : i1, i16
    %278 = comb.concat %c0_i16, %274 : i16, i1
    %279 = sv.read_inout %23 : !hw.inout<i17>
    %280 = comb.extract %279 from 0 : (i17) -> i16
    %281 = comb.concat %false, %280 : i1, i16
    %282 = comb.add %277, %278 : i17
    %283 = comb.add %281, %282 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %23, %283 : i17
    }(syncreset : posedge %reset) {
      sv.passign %23, %c0_i17 : i17
    }
    %284 = sv.read_inout %23 : !hw.inout<i17>
    %285 = comb.extract %284 from 16 : (i17) -> i1
    %286 = sv.read_inout %148 : !hw.inout<i557>
    %287 = comb.extract %286 from 192 : (i557) -> i16
    %288 = comb.concat %false, %287 : i1, i16
    %289 = comb.concat %c0_i16, %285 : i16, i1
    %290 = sv.read_inout %22 : !hw.inout<i17>
    %291 = comb.extract %290 from 0 : (i17) -> i16
    %292 = comb.concat %false, %291 : i1, i16
    %293 = comb.add %288, %289 : i17
    %294 = comb.add %292, %293 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %22, %294 : i17
    }(syncreset : posedge %reset) {
      sv.passign %22, %c0_i17 : i17
    }
    %295 = sv.read_inout %22 : !hw.inout<i17>
    %296 = comb.extract %295 from 16 : (i17) -> i1
    %297 = sv.read_inout %148 : !hw.inout<i557>
    %298 = comb.extract %297 from 208 : (i557) -> i16
    %299 = comb.concat %false, %298 : i1, i16
    %300 = comb.concat %c0_i16, %296 : i16, i1
    %301 = sv.read_inout %21 : !hw.inout<i17>
    %302 = comb.extract %301 from 0 : (i17) -> i16
    %303 = comb.concat %false, %302 : i1, i16
    %304 = comb.add %299, %300 : i17
    %305 = comb.add %303, %304 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %21, %305 : i17
    }(syncreset : posedge %reset) {
      sv.passign %21, %c0_i17 : i17
    }
    %306 = sv.read_inout %21 : !hw.inout<i17>
    %307 = comb.extract %306 from 16 : (i17) -> i1
    %308 = sv.read_inout %148 : !hw.inout<i557>
    %309 = comb.extract %308 from 224 : (i557) -> i16
    %310 = comb.concat %false, %309 : i1, i16
    %311 = comb.concat %c0_i16, %307 : i16, i1
    %312 = sv.read_inout %20 : !hw.inout<i17>
    %313 = comb.extract %312 from 0 : (i17) -> i16
    %314 = comb.concat %false, %313 : i1, i16
    %315 = comb.add %310, %311 : i17
    %316 = comb.add %314, %315 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %20, %316 : i17
    }(syncreset : posedge %reset) {
      sv.passign %20, %c0_i17 : i17
    }
    %317 = sv.read_inout %20 : !hw.inout<i17>
    %318 = comb.extract %317 from 16 : (i17) -> i1
    %319 = sv.read_inout %148 : !hw.inout<i557>
    %320 = comb.extract %319 from 240 : (i557) -> i16
    %321 = comb.concat %false, %320 : i1, i16
    %322 = comb.concat %c0_i16, %318 : i16, i1
    %323 = sv.read_inout %19 : !hw.inout<i17>
    %324 = comb.extract %323 from 0 : (i17) -> i16
    %325 = comb.concat %false, %324 : i1, i16
    %326 = comb.add %321, %322 : i17
    %327 = comb.add %325, %326 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %19, %327 : i17
    }(syncreset : posedge %reset) {
      sv.passign %19, %c0_i17 : i17
    }
    %328 = sv.read_inout %19 : !hw.inout<i17>
    %329 = comb.extract %328 from 16 : (i17) -> i1
    %330 = sv.read_inout %148 : !hw.inout<i557>
    %331 = comb.extract %330 from 256 : (i557) -> i16
    %332 = comb.concat %false, %331 : i1, i16
    %333 = comb.concat %c0_i16, %329 : i16, i1
    %334 = sv.read_inout %18 : !hw.inout<i17>
    %335 = comb.extract %334 from 0 : (i17) -> i16
    %336 = comb.concat %false, %335 : i1, i16
    %337 = comb.add %332, %333 : i17
    %338 = comb.add %336, %337 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %18, %338 : i17
    }(syncreset : posedge %reset) {
      sv.passign %18, %c0_i17 : i17
    }
    %339 = sv.read_inout %18 : !hw.inout<i17>
    %340 = comb.extract %339 from 16 : (i17) -> i1
    %341 = sv.read_inout %148 : !hw.inout<i557>
    %342 = comb.extract %341 from 272 : (i557) -> i16
    %343 = comb.concat %false, %342 : i1, i16
    %344 = comb.concat %c0_i16, %340 : i16, i1
    %345 = sv.read_inout %17 : !hw.inout<i17>
    %346 = comb.extract %345 from 0 : (i17) -> i16
    %347 = comb.concat %false, %346 : i1, i16
    %348 = comb.add %343, %344 : i17
    %349 = comb.add %347, %348 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %17, %349 : i17
    }(syncreset : posedge %reset) {
      sv.passign %17, %c0_i17 : i17
    }
    %350 = sv.read_inout %17 : !hw.inout<i17>
    %351 = comb.extract %350 from 16 : (i17) -> i1
    %352 = sv.read_inout %148 : !hw.inout<i557>
    %353 = comb.extract %352 from 288 : (i557) -> i16
    %354 = comb.concat %false, %353 : i1, i16
    %355 = comb.concat %c0_i16, %351 : i16, i1
    %356 = sv.read_inout %16 : !hw.inout<i17>
    %357 = comb.extract %356 from 0 : (i17) -> i16
    %358 = comb.concat %false, %357 : i1, i16
    %359 = comb.add %354, %355 : i17
    %360 = comb.add %358, %359 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %16, %360 : i17
    }(syncreset : posedge %reset) {
      sv.passign %16, %c0_i17 : i17
    }
    %361 = sv.read_inout %16 : !hw.inout<i17>
    %362 = comb.extract %361 from 16 : (i17) -> i1
    %363 = sv.read_inout %148 : !hw.inout<i557>
    %364 = comb.extract %363 from 304 : (i557) -> i16
    %365 = comb.concat %false, %364 : i1, i16
    %366 = comb.concat %c0_i16, %362 : i16, i1
    %367 = sv.read_inout %15 : !hw.inout<i17>
    %368 = comb.extract %367 from 0 : (i17) -> i16
    %369 = comb.concat %false, %368 : i1, i16
    %370 = comb.add %365, %366 : i17
    %371 = comb.add %369, %370 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %15, %371 : i17
    }(syncreset : posedge %reset) {
      sv.passign %15, %c0_i17 : i17
    }
    %372 = sv.read_inout %15 : !hw.inout<i17>
    %373 = comb.extract %372 from 16 : (i17) -> i1
    %374 = sv.read_inout %148 : !hw.inout<i557>
    %375 = comb.extract %374 from 320 : (i557) -> i16
    %376 = comb.concat %false, %375 : i1, i16
    %377 = comb.concat %c0_i16, %373 : i16, i1
    %378 = sv.read_inout %14 : !hw.inout<i17>
    %379 = comb.extract %378 from 0 : (i17) -> i16
    %380 = comb.concat %false, %379 : i1, i16
    %381 = comb.add %376, %377 : i17
    %382 = comb.add %380, %381 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %14, %382 : i17
    }(syncreset : posedge %reset) {
      sv.passign %14, %c0_i17 : i17
    }
    %383 = sv.read_inout %14 : !hw.inout<i17>
    %384 = comb.extract %383 from 16 : (i17) -> i1
    %385 = sv.read_inout %148 : !hw.inout<i557>
    %386 = comb.extract %385 from 336 : (i557) -> i16
    %387 = comb.concat %false, %386 : i1, i16
    %388 = comb.concat %c0_i16, %384 : i16, i1
    %389 = sv.read_inout %13 : !hw.inout<i17>
    %390 = comb.extract %389 from 0 : (i17) -> i16
    %391 = comb.concat %false, %390 : i1, i16
    %392 = comb.add %387, %388 : i17
    %393 = comb.add %391, %392 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %13, %393 : i17
    }(syncreset : posedge %reset) {
      sv.passign %13, %c0_i17 : i17
    }
    %394 = sv.read_inout %13 : !hw.inout<i17>
    %395 = comb.extract %394 from 16 : (i17) -> i1
    %396 = sv.read_inout %148 : !hw.inout<i557>
    %397 = comb.extract %396 from 352 : (i557) -> i16
    %398 = comb.concat %false, %397 : i1, i16
    %399 = comb.concat %c0_i16, %395 : i16, i1
    %400 = sv.read_inout %12 : !hw.inout<i17>
    %401 = comb.extract %400 from 0 : (i17) -> i16
    %402 = comb.concat %false, %401 : i1, i16
    %403 = comb.add %398, %399 : i17
    %404 = comb.add %402, %403 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %12, %404 : i17
    }(syncreset : posedge %reset) {
      sv.passign %12, %c0_i17 : i17
    }
    %405 = sv.read_inout %12 : !hw.inout<i17>
    %406 = comb.extract %405 from 16 : (i17) -> i1
    %407 = sv.read_inout %148 : !hw.inout<i557>
    %408 = comb.extract %407 from 368 : (i557) -> i16
    %409 = comb.concat %false, %408 : i1, i16
    %410 = comb.concat %c0_i16, %406 : i16, i1
    %411 = sv.read_inout %11 : !hw.inout<i17>
    %412 = comb.extract %411 from 0 : (i17) -> i16
    %413 = comb.concat %false, %412 : i1, i16
    %414 = comb.add %409, %410 : i17
    %415 = comb.add %413, %414 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %11, %415 : i17
    }(syncreset : posedge %reset) {
      sv.passign %11, %c0_i17 : i17
    }
    %416 = sv.read_inout %11 : !hw.inout<i17>
    %417 = comb.extract %416 from 16 : (i17) -> i1
    %418 = sv.read_inout %148 : !hw.inout<i557>
    %419 = comb.extract %418 from 384 : (i557) -> i16
    %420 = comb.concat %false, %419 : i1, i16
    %421 = comb.concat %c0_i16, %417 : i16, i1
    %422 = sv.read_inout %10 : !hw.inout<i17>
    %423 = comb.extract %422 from 0 : (i17) -> i16
    %424 = comb.concat %false, %423 : i1, i16
    %425 = comb.add %420, %421 : i17
    %426 = comb.add %424, %425 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %10, %426 : i17
    }(syncreset : posedge %reset) {
      sv.passign %10, %c0_i17 : i17
    }
    %427 = sv.read_inout %10 : !hw.inout<i17>
    %428 = comb.extract %427 from 16 : (i17) -> i1
    %429 = sv.read_inout %148 : !hw.inout<i557>
    %430 = comb.extract %429 from 400 : (i557) -> i16
    %431 = comb.concat %false, %430 : i1, i16
    %432 = comb.concat %c0_i16, %428 : i16, i1
    %433 = sv.read_inout %9 : !hw.inout<i17>
    %434 = comb.extract %433 from 0 : (i17) -> i16
    %435 = comb.concat %false, %434 : i1, i16
    %436 = comb.add %431, %432 : i17
    %437 = comb.add %435, %436 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %9, %437 : i17
    }(syncreset : posedge %reset) {
      sv.passign %9, %c0_i17 : i17
    }
    %438 = sv.read_inout %9 : !hw.inout<i17>
    %439 = comb.extract %438 from 16 : (i17) -> i1
    %440 = sv.read_inout %148 : !hw.inout<i557>
    %441 = comb.extract %440 from 416 : (i557) -> i16
    %442 = comb.concat %false, %441 : i1, i16
    %443 = comb.concat %c0_i16, %439 : i16, i1
    %444 = sv.read_inout %8 : !hw.inout<i17>
    %445 = comb.extract %444 from 0 : (i17) -> i16
    %446 = comb.concat %false, %445 : i1, i16
    %447 = comb.add %442, %443 : i17
    %448 = comb.add %446, %447 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %8, %448 : i17
    }(syncreset : posedge %reset) {
      sv.passign %8, %c0_i17 : i17
    }
    %449 = sv.read_inout %8 : !hw.inout<i17>
    %450 = comb.extract %449 from 16 : (i17) -> i1
    %451 = sv.read_inout %148 : !hw.inout<i557>
    %452 = comb.extract %451 from 432 : (i557) -> i16
    %453 = comb.concat %false, %452 : i1, i16
    %454 = comb.concat %c0_i16, %450 : i16, i1
    %455 = sv.read_inout %7 : !hw.inout<i17>
    %456 = comb.extract %455 from 0 : (i17) -> i16
    %457 = comb.concat %false, %456 : i1, i16
    %458 = comb.add %453, %454 : i17
    %459 = comb.add %457, %458 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %7, %459 : i17
    }(syncreset : posedge %reset) {
      sv.passign %7, %c0_i17 : i17
    }
    %460 = sv.read_inout %7 : !hw.inout<i17>
    %461 = comb.extract %460 from 16 : (i17) -> i1
    %462 = sv.read_inout %148 : !hw.inout<i557>
    %463 = comb.extract %462 from 448 : (i557) -> i16
    %464 = comb.concat %false, %463 : i1, i16
    %465 = comb.concat %c0_i16, %461 : i16, i1
    %466 = sv.read_inout %6 : !hw.inout<i17>
    %467 = comb.extract %466 from 0 : (i17) -> i16
    %468 = comb.concat %false, %467 : i1, i16
    %469 = comb.add %464, %465 : i17
    %470 = comb.add %468, %469 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %6, %470 : i17
    }(syncreset : posedge %reset) {
      sv.passign %6, %c0_i17 : i17
    }
    %471 = sv.read_inout %6 : !hw.inout<i17>
    %472 = comb.extract %471 from 16 : (i17) -> i1
    %473 = sv.read_inout %148 : !hw.inout<i557>
    %474 = comb.extract %473 from 464 : (i557) -> i16
    %475 = comb.concat %false, %474 : i1, i16
    %476 = comb.concat %c0_i16, %472 : i16, i1
    %477 = sv.read_inout %5 : !hw.inout<i17>
    %478 = comb.extract %477 from 0 : (i17) -> i16
    %479 = comb.concat %false, %478 : i1, i16
    %480 = comb.add %475, %476 : i17
    %481 = comb.add %479, %480 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %5, %481 : i17
    }(syncreset : posedge %reset) {
      sv.passign %5, %c0_i17 : i17
    }
    %482 = sv.read_inout %5 : !hw.inout<i17>
    %483 = comb.extract %482 from 16 : (i17) -> i1
    %484 = sv.read_inout %148 : !hw.inout<i557>
    %485 = comb.extract %484 from 480 : (i557) -> i16
    %486 = comb.concat %false, %485 : i1, i16
    %487 = comb.concat %c0_i16, %483 : i16, i1
    %488 = sv.read_inout %4 : !hw.inout<i17>
    %489 = comb.extract %488 from 0 : (i17) -> i16
    %490 = comb.concat %false, %489 : i1, i16
    %491 = comb.add %486, %487 : i17
    %492 = comb.add %490, %491 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %4, %492 : i17
    }(syncreset : posedge %reset) {
      sv.passign %4, %c0_i17 : i17
    }
    %493 = sv.read_inout %4 : !hw.inout<i17>
    %494 = comb.extract %493 from 16 : (i17) -> i1
    %495 = sv.read_inout %148 : !hw.inout<i557>
    %496 = comb.extract %495 from 496 : (i557) -> i16
    %497 = comb.concat %false, %496 : i1, i16
    %498 = comb.concat %c0_i16, %494 : i16, i1
    %499 = sv.read_inout %3 : !hw.inout<i17>
    %500 = comb.extract %499 from 0 : (i17) -> i16
    %501 = comb.concat %false, %500 : i1, i16
    %502 = comb.add %497, %498 : i17
    %503 = comb.add %501, %502 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %3, %503 : i17
    }(syncreset : posedge %reset) {
      sv.passign %3, %c0_i17 : i17
    }
    %504 = sv.read_inout %3 : !hw.inout<i17>
    %505 = comb.extract %504 from 16 : (i17) -> i1
    %506 = sv.read_inout %148 : !hw.inout<i557>
    %507 = comb.extract %506 from 512 : (i557) -> i16
    %508 = comb.concat %false, %507 : i1, i16
    %509 = comb.concat %c0_i16, %505 : i16, i1
    %510 = sv.read_inout %2 : !hw.inout<i17>
    %511 = comb.extract %510 from 0 : (i17) -> i16
    %512 = comb.concat %false, %511 : i1, i16
    %513 = comb.add %508, %509 : i17
    %514 = comb.add %512, %513 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %2, %514 : i17
    }(syncreset : posedge %reset) {
      sv.passign %2, %c0_i17 : i17
    }
    %515 = sv.read_inout %2 : !hw.inout<i17>
    %516 = comb.extract %515 from 16 : (i17) -> i1
    %517 = sv.read_inout %148 : !hw.inout<i557>
    %518 = comb.extract %517 from 528 : (i557) -> i16
    %519 = comb.concat %false, %518 : i1, i16
    %520 = comb.concat %c0_i16, %516 : i16, i1
    %521 = sv.read_inout %1 : !hw.inout<i17>
    %522 = comb.extract %521 from 0 : (i17) -> i16
    %523 = comb.concat %false, %522 : i1, i16
    %524 = comb.add %519, %520 : i17
    %525 = comb.add %523, %524 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %1, %525 : i17
    }(syncreset : posedge %reset) {
      sv.passign %1, %c0_i17 : i17
    }
    %526 = sv.read_inout %1 : !hw.inout<i17>
    %527 = comb.extract %526 from 16 : (i17) -> i1
    %528 = sv.read_inout %148 : !hw.inout<i557>
    %529 = comb.extract %528 from 544 : (i557) -> i13
    %530 = comb.concat %false, %529 : i1, i13
    %531 = comb.concat %c0_i13, %527 : i13, i1
    %532 = sv.read_inout %0 : !hw.inout<i14>
    %533 = comb.extract %532 from 0 : (i14) -> i13
    %534 = comb.concat %false, %533 : i1, i13
    %535 = comb.add %530, %531 : i14
    %536 = comb.add %534, %535 : i14
    sv.alwaysff(posedge %clk) {
      sv.passign %0, %536 : i14
    }(syncreset : posedge %reset) {
      sv.passign %0, %c0_i14 : i14
    }
    %537 = comb.concat %533, %522, %511, %500, %489, %478, %467, %456, %445, %434, %423, %412, %401, %390, %379, %368, %357, %346, %335, %324, %313, %302, %291, %280, %269, %258, %247, %236, %225, %214, %203, %192, %181, %170, %159 : i13, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16
    %538 = comb.concat %c0_i12, %527, %c0_i15, %516, %c0_i15, %505, %c0_i15, %494, %c0_i15, %483, %c0_i15, %472, %c0_i15, %461, %c0_i15, %450, %c0_i15, %439, %c0_i15, %428, %c0_i15, %417, %c0_i15, %406, %c0_i15, %395, %c0_i15, %384, %c0_i15, %373, %c0_i15, %362, %c0_i15, %351, %c0_i15, %340, %c0_i15, %329, %c0_i15, %318, %c0_i15, %307, %c0_i15, %296, %c0_i15, %285, %c0_i15, %274, %c0_i15, %263, %c0_i15, %252, %c0_i15, %241, %c0_i15, %230, %c0_i15, %219, %c0_i15, %208, %c0_i15, %197, %c0_i15, %186, %c0_i15, %175, %c0_i15, %164, %c0_i16 : i12, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i16
    %539 = comb.add %537, %538 : i557
    %540 = sv.wire {hw.verilogName = "_GEN_49"} : !hw.inout<i557>
    sv.assign %540, %539 : i557
    %541 = sv.read_inout %540 : !hw.inout<i557>
    %542 = comb.icmp eq %541, %c0_i557 : i557
    %543 = sv.wire {hw.verilogName = "_GEN_50"} : !hw.inout<i1>
    sv.assign %543, %542 : i1
    %544 = sv.read_inout %540 : !hw.inout<i557>
    %545 = comb.extract %544 from 556 : (i557) -> i1
    %546 = sv.read_inout %540 : !hw.inout<i557>
    %547 = comb.xor %546, %c-1_i557 : i557
    %548 = comb.add %547, %c1_i557 : i557
    %549 = sv.read_inout %540 : !hw.inout<i557>
    %550 = comb.mux %545, %548, %549 : i557
    %551 = sv.wire {hw.verilogName = "_GEN_51"} : !hw.inout<i557>
    sv.assign %551, %550 : i557
    %552 = sv.read_inout %551 : !hw.inout<i557>
    %553 = comb.extract %552 from 45 : (i557) -> i512
    %554 = comb.icmp eq %553, %c0_i512 : i512
    %555 = sv.wire {hw.verilogName = "_GEN_52"} : !hw.inout<i1>
    sv.assign %555, %554 : i1
    %556 = sv.read_inout %551 : !hw.inout<i557>
    %557 = comb.extract %556 from 0 : (i557) -> i45
    %558 = comb.concat %557, %c0_i466 : i45, i466
    %559 = sv.read_inout %551 : !hw.inout<i557>
    %560 = comb.extract %559 from 46 : (i557) -> i511
    %561 = sv.read_inout %555 : !hw.inout<i1>
    %562 = comb.mux %561, %558, %560 : i511
    %563 = sv.wire {hw.verilogName = "_GEN_53"} : !hw.inout<i511>
    sv.assign %563, %562 : i511
    %564 = sv.read_inout %563 : !hw.inout<i511>
    %565 = comb.extract %564 from 255 : (i511) -> i256
    %566 = comb.icmp eq %565, %c0_i256 : i256
    %567 = sv.wire {hw.verilogName = "_GEN_54"} : !hw.inout<i1>
    sv.assign %567, %566 : i1
    %568 = sv.read_inout %563 : !hw.inout<i511>
    %569 = comb.extract %568 from 0 : (i511) -> i255
    %570 = sv.read_inout %563 : !hw.inout<i511>
    %571 = comb.extract %570 from 256 : (i511) -> i255
    %572 = sv.read_inout %567 : !hw.inout<i1>
    %573 = comb.mux %572, %569, %571 : i255
    %574 = sv.wire {hw.verilogName = "_GEN_55"} : !hw.inout<i255>
    sv.assign %574, %573 : i255
    %575 = sv.read_inout %574 : !hw.inout<i255>
    %576 = comb.extract %575 from 127 : (i255) -> i128
    %577 = comb.icmp eq %576, %c0_i128 : i128
    %578 = sv.wire {hw.verilogName = "_GEN_56"} : !hw.inout<i1>
    sv.assign %578, %577 : i1
    %579 = sv.read_inout %574 : !hw.inout<i255>
    %580 = comb.extract %579 from 0 : (i255) -> i127
    %581 = sv.read_inout %574 : !hw.inout<i255>
    %582 = comb.extract %581 from 128 : (i255) -> i127
    %583 = sv.read_inout %578 : !hw.inout<i1>
    %584 = comb.mux %583, %580, %582 : i127
    %585 = sv.wire {hw.verilogName = "_GEN_57"} : !hw.inout<i127>
    sv.assign %585, %584 : i127
    %586 = sv.read_inout %585 : !hw.inout<i127>
    %587 = comb.extract %586 from 63 : (i127) -> i64
    %588 = comb.icmp eq %587, %c0_i64 : i64
    %589 = sv.wire {hw.verilogName = "_GEN_58"} : !hw.inout<i1>
    sv.assign %589, %588 : i1
    %590 = sv.read_inout %585 : !hw.inout<i127>
    %591 = comb.extract %590 from 0 : (i127) -> i63
    %592 = sv.read_inout %585 : !hw.inout<i127>
    %593 = comb.extract %592 from 64 : (i127) -> i63
    %594 = sv.read_inout %589 : !hw.inout<i1>
    %595 = comb.mux %594, %591, %593 : i63
    %596 = sv.wire {hw.verilogName = "_GEN_59"} : !hw.inout<i63>
    sv.assign %596, %595 : i63
    %597 = sv.read_inout %596 : !hw.inout<i63>
    %598 = comb.extract %597 from 31 : (i63) -> i32
    %599 = comb.icmp eq %598, %c0_i32 : i32
    %600 = sv.wire {hw.verilogName = "_GEN_60"} : !hw.inout<i1>
    sv.assign %600, %599 : i1
    %601 = sv.read_inout %596 : !hw.inout<i63>
    %602 = comb.extract %601 from 0 : (i63) -> i31
    %603 = sv.read_inout %596 : !hw.inout<i63>
    %604 = comb.extract %603 from 32 : (i63) -> i31
    %605 = sv.read_inout %600 : !hw.inout<i1>
    %606 = comb.mux %605, %602, %604 : i31
    %607 = sv.wire {hw.verilogName = "_GEN_61"} : !hw.inout<i31>
    sv.assign %607, %606 : i31
    %608 = sv.read_inout %607 : !hw.inout<i31>
    %609 = comb.extract %608 from 15 : (i31) -> i16
    %610 = comb.icmp eq %609, %c0_i16 : i16
    %611 = sv.wire {hw.verilogName = "_GEN_62"} : !hw.inout<i1>
    sv.assign %611, %610 : i1
    %612 = sv.read_inout %607 : !hw.inout<i31>
    %613 = comb.extract %612 from 0 : (i31) -> i15
    %614 = sv.read_inout %607 : !hw.inout<i31>
    %615 = comb.extract %614 from 16 : (i31) -> i15
    %616 = sv.read_inout %611 : !hw.inout<i1>
    %617 = comb.mux %616, %613, %615 : i15
    %618 = sv.wire {hw.verilogName = "_GEN_63"} : !hw.inout<i15>
    sv.assign %618, %617 : i15
    %619 = sv.read_inout %618 : !hw.inout<i15>
    %620 = comb.extract %619 from 7 : (i15) -> i8
    %621 = comb.icmp eq %620, %c0_i8 : i8
    %622 = sv.wire {hw.verilogName = "_GEN_64"} : !hw.inout<i1>
    sv.assign %622, %621 : i1
    %623 = sv.read_inout %618 : !hw.inout<i15>
    %624 = comb.extract %623 from 0 : (i15) -> i7
    %625 = sv.read_inout %618 : !hw.inout<i15>
    %626 = comb.extract %625 from 8 : (i15) -> i7
    %627 = sv.read_inout %622 : !hw.inout<i1>
    %628 = comb.mux %627, %624, %626 : i7
    %629 = sv.wire {hw.verilogName = "_GEN_65"} : !hw.inout<i7>
    sv.assign %629, %628 : i7
    %630 = sv.read_inout %629 : !hw.inout<i7>
    %631 = comb.extract %630 from 3 : (i7) -> i4
    %632 = comb.icmp eq %631, %c0_i4 : i4
    %633 = sv.wire {hw.verilogName = "_GEN_66"} : !hw.inout<i1>
    sv.assign %633, %632 : i1
    %634 = sv.read_inout %629 : !hw.inout<i7>
    %635 = comb.extract %634 from 0 : (i7) -> i3
    %636 = sv.read_inout %629 : !hw.inout<i7>
    %637 = comb.extract %636 from 4 : (i7) -> i3
    %638 = sv.read_inout %633 : !hw.inout<i1>
    %639 = comb.mux %638, %635, %637 : i3
    %640 = sv.wire {hw.verilogName = "_GEN_67"} : !hw.inout<i3>
    sv.assign %640, %639 : i3
    %641 = sv.read_inout %640 : !hw.inout<i3>
    %642 = comb.extract %641 from 1 : (i3) -> i2
    %643 = comb.icmp eq %642, %c0_i2 : i2
    %644 = sv.wire {hw.verilogName = "_GEN_68"} : !hw.inout<i1>
    sv.assign %644, %643 : i1
    %645 = sv.read_inout %640 : !hw.inout<i3>
    %646 = comb.extract %645 from 0 : (i3) -> i1
    %647 = sv.read_inout %640 : !hw.inout<i3>
    %648 = comb.extract %647 from 2 : (i3) -> i1
    %649 = sv.read_inout %644 : !hw.inout<i1>
    %650 = comb.mux %649, %646, %648 : i1
    %651 = comb.xor %650, %true : i1
    %652 = sv.wire {hw.verilogName = "_GEN_69"} : !hw.inout<i1>
    sv.assign %652, %651 : i1
    %653 = sv.read_inout %551 : !hw.inout<i557>
    %654 = comb.extract %653 from 0 : (i557) -> i44
    %655 = comb.concat %654, %c0_i512 : i44, i512
    %656 = sv.read_inout %551 : !hw.inout<i557>
    %657 = comb.extract %656 from 0 : (i557) -> i556
    %658 = sv.read_inout %555 : !hw.inout<i1>
    %659 = comb.mux %658, %655, %657 : i556
    %660 = sv.wire {hw.verilogName = "_GEN_70"} : !hw.inout<i556>
    sv.assign %660, %659 : i556
    %661 = sv.read_inout %660 : !hw.inout<i556>
    %662 = comb.extract %661 from 0 : (i556) -> i300
    %663 = comb.concat %662, %c0_i256 : i300, i256
    %664 = sv.read_inout %567 : !hw.inout<i1>
    %665 = sv.read_inout %660 : !hw.inout<i556>
    %666 = comb.mux %664, %663, %665 : i556
    %667 = sv.wire {hw.verilogName = "_GEN_71"} : !hw.inout<i556>
    sv.assign %667, %666 : i556
    %668 = sv.read_inout %667 : !hw.inout<i556>
    %669 = comb.extract %668 from 0 : (i556) -> i428
    %670 = comb.concat %669, %c0_i128 : i428, i128
    %671 = sv.read_inout %578 : !hw.inout<i1>
    %672 = sv.read_inout %667 : !hw.inout<i556>
    %673 = comb.mux %671, %670, %672 : i556
    %674 = sv.wire {hw.verilogName = "_GEN_72"} : !hw.inout<i556>
    sv.assign %674, %673 : i556
    %675 = sv.read_inout %674 : !hw.inout<i556>
    %676 = comb.extract %675 from 0 : (i556) -> i492
    %677 = comb.concat %676, %c0_i64 : i492, i64
    %678 = sv.read_inout %589 : !hw.inout<i1>
    %679 = sv.read_inout %674 : !hw.inout<i556>
    %680 = comb.mux %678, %677, %679 : i556
    %681 = sv.wire {hw.verilogName = "_GEN_73"} : !hw.inout<i556>
    sv.assign %681, %680 : i556
    %682 = sv.read_inout %681 : !hw.inout<i556>
    %683 = comb.extract %682 from 0 : (i556) -> i524
    %684 = comb.concat %683, %c0_i32 : i524, i32
    %685 = sv.read_inout %600 : !hw.inout<i1>
    %686 = sv.read_inout %681 : !hw.inout<i556>
    %687 = comb.mux %685, %684, %686 : i556
    %688 = sv.wire {hw.verilogName = "_GEN_74"} : !hw.inout<i556>
    sv.assign %688, %687 : i556
    %689 = sv.read_inout %688 : !hw.inout<i556>
    %690 = comb.extract %689 from 0 : (i556) -> i540
    %691 = comb.concat %690, %c0_i16 : i540, i16
    %692 = sv.read_inout %611 : !hw.inout<i1>
    %693 = sv.read_inout %688 : !hw.inout<i556>
    %694 = comb.mux %692, %691, %693 : i556
    %695 = sv.wire {hw.verilogName = "_GEN_75"} : !hw.inout<i556>
    sv.assign %695, %694 : i556
    %696 = sv.read_inout %695 : !hw.inout<i556>
    %697 = comb.extract %696 from 0 : (i556) -> i548
    %698 = comb.concat %697, %c0_i8 : i548, i8
    %699 = sv.read_inout %622 : !hw.inout<i1>
    %700 = sv.read_inout %695 : !hw.inout<i556>
    %701 = comb.mux %699, %698, %700 : i556
    %702 = sv.wire {hw.verilogName = "_GEN_76"} : !hw.inout<i556>
    sv.assign %702, %701 : i556
    %703 = sv.read_inout %702 : !hw.inout<i556>
    %704 = comb.extract %703 from 0 : (i556) -> i552
    %705 = comb.concat %704, %c0_i4 : i552, i4
    %706 = sv.read_inout %633 : !hw.inout<i1>
    %707 = sv.read_inout %702 : !hw.inout<i556>
    %708 = comb.mux %706, %705, %707 : i556
    %709 = sv.wire {hw.verilogName = "_GEN_77"} : !hw.inout<i556>
    sv.assign %709, %708 : i556
    %710 = sv.read_inout %709 : !hw.inout<i556>
    %711 = comb.extract %710 from 0 : (i556) -> i554
    %712 = comb.concat %711, %c0_i2 : i554, i2
    %713 = sv.read_inout %644 : !hw.inout<i1>
    %714 = sv.read_inout %709 : !hw.inout<i556>
    %715 = comb.mux %713, %712, %714 : i556
    %716 = sv.wire {hw.verilogName = "_GEN_78"} : !hw.inout<i556>
    sv.assign %716, %715 : i556
    %717 = sv.read_inout %716 : !hw.inout<i556>
    %718 = comb.extract %717 from 0 : (i556) -> i555
    %719 = comb.concat %718, %false : i555, i1
    %720 = sv.read_inout %652 : !hw.inout<i1>
    %721 = sv.read_inout %716 : !hw.inout<i556>
    %722 = comb.mux %720, %719, %721 : i556
    %723 = sv.wire {hw.verilogName = "_GEN_79"} : !hw.inout<i556>
    sv.assign %723, %722 : i556
    %724 = sv.read_inout %723 : !hw.inout<i556>
    %725 = comb.extract %724 from 0 : (i556) -> i531
    %726 = comb.icmp ne %725, %c0_i531 : i531
    %727 = sv.read_inout %555 : !hw.inout<i1>
    %728 = sv.read_inout %567 : !hw.inout<i1>
    %729 = sv.read_inout %578 : !hw.inout<i1>
    %730 = sv.read_inout %589 : !hw.inout<i1>
    %731 = sv.read_inout %600 : !hw.inout<i1>
    %732 = sv.read_inout %611 : !hw.inout<i1>
    %733 = sv.read_inout %622 : !hw.inout<i1>
    %734 = sv.read_inout %633 : !hw.inout<i1>
    %735 = sv.read_inout %644 : !hw.inout<i1>
    %736 = sv.read_inout %652 : !hw.inout<i1>
    %737 = comb.concat %c0_i2, %727, %728, %729, %730, %731, %732, %733, %734, %735, %736 : i2, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
    %738 = comb.sub %c258_i12, %737 : i12
    %739 = sv.read_inout %723 : !hw.inout<i556>
    %740 = comb.extract %739 from 533 : (i556) -> i23
    %741 = sv.read_inout %723 : !hw.inout<i556>
    %742 = comb.extract %741 from 532 : (i556) -> i1
    %743 = sv.read_inout %723 : !hw.inout<i556>
    %744 = comb.extract %743 from 531 : (i556) -> i1
    %745 = sv.read_inout %723 : !hw.inout<i556>
    %746 = comb.extract %745 from 533 : (i556) -> i1
    %747 = comb.or %726, %746 : i1
    %748 = comb.or %744, %747 : i1
    %749 = comb.and %742, %748 : i1
    %750 = comb.concat %c0_i24, %749 : i24, i1
    %751 = comb.concat %c1_i2, %740 : i2, i23
    %752 = comb.add %751, %750 : i25
    %753 = sv.wire {hw.verilogName = "_GEN_80"} : !hw.inout<i25>
    sv.assign %753, %752 : i25
    %754 = sv.read_inout %753 : !hw.inout<i25>
    %755 = comb.extract %754 from 24 : (i25) -> i1
    %756 = sv.read_inout %753 : !hw.inout<i25>
    %757 = comb.extract %756 from 1 : (i25) -> i23
    %758 = sv.read_inout %753 : !hw.inout<i25>
    %759 = comb.extract %758 from 0 : (i25) -> i23
    %760 = comb.mux %755, %757, %759 : i23
    %761 = comb.concat %c0_i11, %755 : i11, i1
    %762 = comb.add %761, %c127_i12 : i12
    %763 = comb.add %738, %762 : i12
    %764 = sv.wire {hw.verilogName = "_GEN_81"} : !hw.inout<i12>
    sv.assign %764, %763 : i12
    %765 = sv.read_inout %764 : !hw.inout<i12>
    %766 = comb.icmp slt %765, %c1_i12 : i12
    %767 = sv.wire {hw.verilogName = "_GEN_82"} : !hw.inout<i1>
    sv.assign %767, %766 : i1
    %768 = sv.read_inout %764 : !hw.inout<i12>
    %769 = comb.icmp sgt %768, %c254_i12 : i12
    %770 = sv.wire {hw.verilogName = "_GEN_83"} : !hw.inout<i1>
    sv.assign %770, %769 : i1
    %771 = sv.read_inout %764 : !hw.inout<i12>
    %772 = comb.extract %771 from 0 : (i12) -> i8
    %773 = sv.read_inout %543 : !hw.inout<i1>
    %774 = sv.read_inout %767 : !hw.inout<i1>
    %775 = comb.or %774, %773 : i1
    %776 = comb.mux %775, %c0_i8, %772 : i8
    %777 = sv.read_inout %770 : !hw.inout<i1>
    %778 = comb.mux %777, %c-1_i8, %776 : i8
    %779 = sv.read_inout %543 : !hw.inout<i1>
    %780 = sv.read_inout %767 : !hw.inout<i1>
    %781 = sv.read_inout %770 : !hw.inout<i1>
    %782 = comb.or %779, %781 : i1
    %783 = comb.or %780, %782 : i1
    %784 = comb.mux %783, %c0_i23, %760 : i23
    %785 = comb.concat %545, %778, %784 : i1, i8, i23
    %786 = sv.read_inout %35 : !hw.inout<i1>
    %787 = comb.mux %786, %c2143289344_i32, %785 : i32
    hw.output %787 : i32
  }
}

