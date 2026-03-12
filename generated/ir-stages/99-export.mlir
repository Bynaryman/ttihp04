module attributes {circt.loweringOptions = "locationInfoStyle=none"} {
  hw.module @fpmult_loop_muladd_s3fdp(in %clk : i1 {hw.name = "clk"}, in %reset : i1 {hw.name = "reset"}, in %a : !hw.array<4xi32> {hw.name = "a"}, in %b : !hw.array<4xi32> {hw.name = "b"}, in %c : !hw.array<2xi32> {hw.name = "c"}, in %clk_0 : i1, out r : i32 {hw.name = "r"}) {
    %0 = sv.wire {hw.verilogName = "_GEN"} : !hw.inout<i32>
    %1 = sv.wire {hw.verilogName = "_GEN_0"} : !hw.inout<i32>
    %2 = sv.wire {hw.verilogName = "_GEN_1"} : !hw.inout<i1>
    %_s3fdp_accum_r = sv.wire {hw.verilogName = "_s3fdp_accum_r"} : !hw.inout<i32>
    %true = hw.constant true
    %c1_i32 = hw.constant 1 : i32
    %c3_i32 = hw.constant 3 : i32
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %3 = hw.bitcast %b : (!hw.array<4xi32>) -> i128
    %4 = sv.wire {hw.verilogName = "_GEN_2"} : !hw.inout<i128>
    sv.assign %4, %3 : i128
    %5 = hw.bitcast %a : (!hw.array<4xi32>) -> i128
    %6 = sv.wire {hw.verilogName = "_GEN_3"} : !hw.inout<i128>
    sv.assign %6, %5 : i128
    %c_mem = sv.reg {hw.verilogName = "c_mem"} : !hw.inout<uarray<2xi32>> 
    sv.alwaysff(posedge %clk_0) {
      %56 = sv.read_inout %2 : !hw.inout<i1>
      sv.if %56 {
        %57 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi32>>, i1
        %58 = sv.read_inout %_s3fdp_accum_r : !hw.inout<i32>
        sv.passign %57, %58 : i32
      }
    }(syncreset : posedge %reset) {
    }
    %7 = sv.reg {hw.verilogName = "_GEN_4"} : !hw.inout<i32> 
    sv.alwaysff(posedge %clk_0) {
      %56 = sv.read_inout %0 : !hw.inout<i32>
      sv.passign %7, %56 : i32
    }(syncreset : posedge %reset) {
      sv.passign %7, %c0_i32 : i32
    }
    %8 = sv.read_inout %7 : !hw.inout<i32>
    %9 = comb.icmp eq %8, %c0_i32 : i32
    sv.assign %2, %9 : i1
    %10 = sv.reg {hw.verilogName = "_GEN_5"} : !hw.inout<i32> 
    sv.alwaysff(posedge %clk_0) {
      %56 = sv.read_inout %1 : !hw.inout<i32>
      sv.passign %10, %56 : i32
    }(syncreset : posedge %reset) {
      sv.passign %10, %c0_i32 : i32
    }
    %11 = sv.read_inout %10 : !hw.inout<i32>
    %12 = comb.icmp eq %11, %c3_i32 : i32
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
    %24 = sv.read_inout %6 : !hw.inout<i128>
    %25 = comb.extract %24 from 0 : (i128) -> i32
    %26 = sv.read_inout %6 : !hw.inout<i128>
    %27 = comb.extract %26 from 32 : (i128) -> i32
    %28 = sv.read_inout %6 : !hw.inout<i128>
    %29 = comb.extract %28 from 64 : (i128) -> i32
    %30 = sv.read_inout %6 : !hw.inout<i128>
    %31 = comb.extract %30 from 96 : (i128) -> i32
    %32 = sv.read_inout %10 : !hw.inout<i32>
    %33 = comb.extract %32 from 0 : (i32) -> i1
    %34 = sv.read_inout %10 : !hw.inout<i32>
    %35 = comb.extract %34 from 1 : (i32) -> i1
    %36 = comb.mux %33, %31, %29 : i32
    %37 = comb.mux %33, %27, %25 : i32
    %38 = comb.mux %35, %36, %37 : i32
    %39 = sv.read_inout %4 : !hw.inout<i128>
    %40 = comb.extract %39 from 0 : (i128) -> i32
    %41 = sv.read_inout %4 : !hw.inout<i128>
    %42 = comb.extract %41 from 32 : (i128) -> i32
    %43 = sv.read_inout %4 : !hw.inout<i128>
    %44 = comb.extract %43 from 64 : (i128) -> i32
    %45 = sv.read_inout %4 : !hw.inout<i128>
    %46 = comb.extract %45 from 96 : (i128) -> i32
    %47 = comb.mux %33, %46, %44 : i32
    %48 = comb.mux %33, %42, %40 : i32
    %49 = comb.mux %35, %47, %48 : i32
    %cg_en_latch = sv.reg {hw.verilogName = "cg_en_latch"} : !hw.inout<i1> 
    sv.always  {
      %56 = comb.xor %clk, %true : i1
      sv.if %56 {
        %57 = sv.read_inout %2 : !hw.inout<i1>
        sv.passign %cg_en_latch, %57 : i1
      }
    }
    %50 = sv.read_inout %cg_en_latch : !hw.inout<i1>
    %51 = comb.and %clk, %50 : i1
    %s3fdp_accum.r = hw.instance "s3fdp_accum" @s3fdp_accum_core_wE8_wF23_cs16(clk: %51: i1, reset: %reset: i1, x: %38: i32, y: %49: i32) -> (r: i32) {hw.verilogName = "s3fdp_accum"}
    sv.assign %_s3fdp_accum_r, %s3fdp_accum.r : i32
    %52 = sv.read_inout %7 : !hw.inout<i32>
    %53 = comb.mux %23, %c0_i32, %52 : i32
    sv.assign %0, %53 : i32
    %54 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi32>>, i1
    %55 = sv.read_inout %54 : !hw.inout<i32>
    hw.output %55 : i32
  }
  hw.module @s3fdp_accum_core_wE8_wF23_cs16(in %clk : i1, in %reset : i1, in %x : i32, in %y : i32, out r : i32) {
    %0 = sv.reg {hw.verilogName = "_GEN"} : !hw.inout<i3> 
    %1 = sv.reg {hw.verilogName = "_GEN_0"} : !hw.inout<i17> 
    %2 = sv.reg {hw.verilogName = "_GEN_1"} : !hw.inout<i1> 
    %c0_i65 = hw.constant 0 : i65
    %c0_i13 = hw.constant 0 : i13
    %c2143289344_i32 = hw.constant 2143289344 : i32
    %c1_i10 = hw.constant 1 : i10
    %c0_i6 = hw.constant 0 : i6
    %c254_i10 = hw.constant 254 : i10
    %c0_i23 = hw.constant 0 : i23
    %c127_i10 = hw.constant 127 : i10
    %c11_i10 = hw.constant 11 : i10
    %c0_i5 = hw.constant 0 : i5
    %c1_i18 = hw.constant 1 : i18
    %c-1_i18 = hw.constant -1 : i18
    %c0_i9 = hw.constant 0 : i9
    %c0_i3 = hw.constant 0 : i3
    %c0_i17 = hw.constant 0 : i17
    %c0_i18 = hw.constant 0 : i18
    %c12_i9 = hw.constant 12 : i9
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %c0_i16 = hw.constant 0 : i16
    %c0_i64 = hw.constant 0 : i64
    %c0_i24 = hw.constant 0 : i24
    %false = hw.constant false
    %c1_i8 = hw.constant 1 : i8
    %true = hw.constant true
    %c-1_i8 = hw.constant -1 : i8
    %c0_i8 = hw.constant 0 : i8
    %3 = comb.extract %x from 31 : (i32) -> i1
    %4 = comb.extract %x from 23 : (i32) -> i8
    %5 = comb.extract %x from 0 : (i32) -> i23
    %6 = comb.icmp eq %4, %c0_i8 : i8
    %7 = sv.wire {hw.verilogName = "_GEN_2"} : !hw.inout<i1>
    sv.assign %7, %6 : i1
    %8 = comb.icmp eq %4, %c-1_i8 : i8
    %9 = sv.read_inout %7 : !hw.inout<i1>
    %10 = comb.xor %9, %true : i1
    %11 = sv.read_inout %7 : !hw.inout<i1>
    %12 = comb.mux %11, %c1_i8, %4 : i8
    %13 = comb.extract %y from 31 : (i32) -> i1
    %14 = comb.extract %y from 23 : (i32) -> i8
    %15 = comb.extract %y from 0 : (i32) -> i23
    %16 = comb.icmp eq %14, %c0_i8 : i8
    %17 = sv.wire {hw.verilogName = "_GEN_3"} : !hw.inout<i1>
    sv.assign %17, %16 : i1
    %18 = comb.icmp eq %14, %c-1_i8 : i8
    %19 = sv.read_inout %17 : !hw.inout<i1>
    %20 = comb.xor %19, %true : i1
    %21 = sv.read_inout %17 : !hw.inout<i1>
    %22 = comb.mux %21, %c1_i8, %14 : i8
    %23 = comb.xor %3, %13 : i1
    %24 = sv.wire {hw.verilogName = "_GEN_4"} : !hw.inout<i1>
    sv.assign %24, %23 : i1
    %25 = comb.concat %c0_i24, %10, %5 : i24, i1, i23
    %26 = comb.concat %c0_i24, %20, %15 : i24, i1, i23
    %27 = comb.mul %25, %26 : i48
    %28 = comb.concat %false, %22 : i1, i8
    %29 = comb.concat %false, %12 : i1, i8
    %30 = sv.read_inout %24 : !hw.inout<i1>
    %31 = comb.replicate %30 : (i1) -> i48
    %32 = comb.xor %31, %27 : i48
    %c247_i9 = hw.constant 247 : i9
    %33 = comb.sub %28, %c247_i9 : i9
    %34 = comb.add %29, %33 : i9
    %35 = sv.wire {hw.verilogName = "_GEN_5"} : !hw.inout<i9>
    sv.assign %35, %34 : i9
    %36 = sv.read_inout %35 : !hw.inout<i9>
    %37 = comb.extract %36 from 8 : (i9) -> i1
    %38 = comb.concat %c0_i17, %32 : i17, i48
    %39 = sv.read_inout %35 : !hw.inout<i9>
    %40 = comb.extract %39 from 7 : (i9) -> i1
    %41 = comb.or %40, %37 : i1
    %42 = comb.mux %41, %c0_i65, %38 : i65
    %43 = sv.wire {hw.verilogName = "_GEN_6"} : !hw.inout<i65>
    sv.assign %43, %42 : i65
    %44 = sv.read_inout %35 : !hw.inout<i9>
    %45 = comb.extract %44 from 6 : (i9) -> i1
    %46 = sv.read_inout %43 : !hw.inout<i65>
    %47 = comb.extract %46 from 0 : (i65) -> i1
    %48 = comb.concat %47, %c0_i64 : i1, i64
    %49 = sv.read_inout %43 : !hw.inout<i65>
    %50 = comb.mux %45, %48, %49 : i65
    %51 = sv.wire {hw.verilogName = "_GEN_7"} : !hw.inout<i65>
    sv.assign %51, %50 : i65
    %52 = sv.read_inout %35 : !hw.inout<i9>
    %53 = comb.extract %52 from 5 : (i9) -> i1
    %54 = sv.read_inout %51 : !hw.inout<i65>
    %55 = comb.extract %54 from 0 : (i65) -> i33
    %56 = comb.concat %55, %c0_i16 : i33, i16
    %57 = sv.read_inout %51 : !hw.inout<i65>
    %58 = comb.extract %57 from 16 : (i65) -> i49
    %59 = comb.mux %53, %56, %58 : i49
    %60 = sv.wire {hw.verilogName = "_GEN_8"} : !hw.inout<i49>
    sv.assign %60, %59 : i49
    %61 = sv.read_inout %35 : !hw.inout<i9>
    %62 = comb.extract %61 from 4 : (i9) -> i1
    %63 = sv.read_inout %60 : !hw.inout<i49>
    %64 = comb.extract %63 from 0 : (i49) -> i33
    %65 = sv.read_inout %60 : !hw.inout<i49>
    %66 = comb.extract %65 from 16 : (i49) -> i33
    %67 = comb.mux %62, %64, %66 : i33
    %68 = sv.wire {hw.verilogName = "_GEN_9"} : !hw.inout<i33>
    sv.assign %68, %67 : i33
    %69 = sv.read_inout %35 : !hw.inout<i9>
    %70 = comb.extract %69 from 3 : (i9) -> i1
    %71 = sv.read_inout %68 : !hw.inout<i33>
    %72 = comb.extract %71 from 0 : (i33) -> i25
    %73 = sv.read_inout %68 : !hw.inout<i33>
    %74 = comb.extract %73 from 8 : (i33) -> i25
    %75 = comb.mux %70, %72, %74 : i25
    %76 = sv.wire {hw.verilogName = "_GEN_10"} : !hw.inout<i25>
    sv.assign %76, %75 : i25
    %77 = sv.read_inout %35 : !hw.inout<i9>
    %78 = comb.extract %77 from 2 : (i9) -> i1
    %79 = sv.read_inout %76 : !hw.inout<i25>
    %80 = comb.extract %79 from 0 : (i25) -> i21
    %81 = sv.read_inout %76 : !hw.inout<i25>
    %82 = comb.extract %81 from 4 : (i25) -> i21
    %83 = comb.mux %78, %80, %82 : i21
    %84 = sv.wire {hw.verilogName = "_GEN_11"} : !hw.inout<i21>
    sv.assign %84, %83 : i21
    %85 = sv.read_inout %35 : !hw.inout<i9>
    %86 = comb.extract %85 from 1 : (i9) -> i1
    %87 = sv.read_inout %84 : !hw.inout<i21>
    %88 = comb.extract %87 from 0 : (i21) -> i19
    %89 = sv.read_inout %84 : !hw.inout<i21>
    %90 = comb.extract %89 from 2 : (i21) -> i19
    %91 = comb.mux %86, %88, %90 : i19
    %92 = sv.wire {hw.verilogName = "_GEN_12"} : !hw.inout<i19>
    sv.assign %92, %91 : i19
    %93 = sv.read_inout %35 : !hw.inout<i9>
    %94 = comb.extract %93 from 0 : (i9) -> i1
    %95 = sv.read_inout %92 : !hw.inout<i19>
    %96 = comb.extract %95 from 0 : (i19) -> i18
    %97 = sv.read_inout %92 : !hw.inout<i19>
    %98 = comb.extract %97 from 1 : (i19) -> i18
    %99 = comb.mux %94, %96, %98 : i18
    %100 = sv.read_inout %35 : !hw.inout<i9>
    %101 = comb.icmp sgt %100, %c12_i9 : i9
    %102 = comb.mux %37, %c0_i18, %99 : i18
    %103 = sv.wire {hw.verilogName = "_GEN_13"} : !hw.inout<i18>
    sv.assign %103, %102 : i18
    %104 = comb.or %101, %8 : i1
    %105 = sv.read_inout %2 : !hw.inout<i1>
    %106 = comb.or %18, %105 : i1
    %107 = comb.or %104, %106 : i1
    sv.alwaysff(posedge %clk) {
      sv.passign %2, %107 : i1
    }(syncreset : posedge %reset) {
      sv.passign %2, %false : i1
    }
    %108 = sv.read_inout %103 : !hw.inout<i18>
    %109 = comb.extract %108 from 0 : (i18) -> i16
    %110 = comb.concat %false, %109 : i1, i16
    %111 = sv.read_inout %24 : !hw.inout<i1>
    %112 = comb.concat %c0_i16, %111 : i16, i1
    %113 = sv.read_inout %1 : !hw.inout<i17>
    %114 = comb.extract %113 from 0 : (i17) -> i16
    %115 = comb.concat %false, %114 : i1, i16
    %116 = comb.add %110, %112 : i17
    %117 = comb.add %115, %116 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %1, %117 : i17
    }(syncreset : posedge %reset) {
      sv.passign %1, %c0_i17 : i17
    }
    %118 = sv.read_inout %1 : !hw.inout<i17>
    %119 = comb.extract %118 from 16 : (i17) -> i1
    %120 = sv.read_inout %103 : !hw.inout<i18>
    %121 = comb.extract %120 from 16 : (i18) -> i2
    %122 = comb.concat %false, %121 : i1, i2
    %123 = comb.concat %c0_i2, %119 : i2, i1
    %124 = sv.read_inout %0 : !hw.inout<i3>
    %125 = comb.extract %124 from 0 : (i3) -> i2
    %126 = comb.concat %false, %125 : i1, i2
    %127 = comb.add %122, %123 : i3
    %128 = comb.add %126, %127 : i3
    sv.alwaysff(posedge %clk) {
      sv.passign %0, %128 : i3
    }(syncreset : posedge %reset) {
      sv.passign %0, %c0_i3 : i3
    }
    %129 = comb.concat %125, %114 : i2, i16
    %130 = comb.concat %c0_i8, %119, %c0_i9 : i8, i1, i9
    %131 = comb.add %129, %130 : i18
    %132 = sv.wire {hw.verilogName = "_GEN_14"} : !hw.inout<i18>
    sv.assign %132, %131 : i18
    %133 = sv.read_inout %132 : !hw.inout<i18>
    %134 = comb.icmp eq %133, %c0_i18 : i18
    %135 = sv.wire {hw.verilogName = "_GEN_15"} : !hw.inout<i1>
    sv.assign %135, %134 : i1
    %136 = sv.read_inout %132 : !hw.inout<i18>
    %137 = comb.extract %136 from 17 : (i18) -> i1
    %138 = sv.read_inout %132 : !hw.inout<i18>
    %139 = comb.xor %138, %c-1_i18 : i18
    %140 = comb.add %139, %c1_i18 : i18
    %141 = sv.read_inout %132 : !hw.inout<i18>
    %142 = comb.mux %137, %140, %141 : i18
    %143 = sv.wire {hw.verilogName = "_GEN_16"} : !hw.inout<i18>
    sv.assign %143, %142 : i18
    %144 = sv.read_inout %143 : !hw.inout<i18>
    %145 = comb.extract %144 from 2 : (i18) -> i16
    %146 = comb.icmp eq %145, %c0_i16 : i16
    %147 = sv.wire {hw.verilogName = "_GEN_17"} : !hw.inout<i1>
    sv.assign %147, %146 : i1
    %148 = sv.read_inout %143 : !hw.inout<i18>
    %149 = comb.extract %148 from 0 : (i18) -> i2
    %150 = comb.concat %149, %c0_i13 : i2, i13
    %151 = sv.read_inout %143 : !hw.inout<i18>
    %152 = comb.extract %151 from 3 : (i18) -> i15
    %153 = sv.read_inout %147 : !hw.inout<i1>
    %154 = comb.mux %153, %150, %152 : i15
    %155 = sv.wire {hw.verilogName = "_GEN_18"} : !hw.inout<i15>
    sv.assign %155, %154 : i15
    %156 = sv.read_inout %155 : !hw.inout<i15>
    %157 = comb.extract %156 from 7 : (i15) -> i8
    %158 = comb.icmp eq %157, %c0_i8 : i8
    %159 = sv.wire {hw.verilogName = "_GEN_19"} : !hw.inout<i1>
    sv.assign %159, %158 : i1
    %160 = sv.read_inout %155 : !hw.inout<i15>
    %161 = comb.extract %160 from 0 : (i15) -> i7
    %162 = sv.read_inout %155 : !hw.inout<i15>
    %163 = comb.extract %162 from 8 : (i15) -> i7
    %164 = sv.read_inout %159 : !hw.inout<i1>
    %165 = comb.mux %164, %161, %163 : i7
    %166 = sv.wire {hw.verilogName = "_GEN_20"} : !hw.inout<i7>
    sv.assign %166, %165 : i7
    %167 = sv.read_inout %166 : !hw.inout<i7>
    %168 = comb.extract %167 from 3 : (i7) -> i4
    %169 = comb.icmp eq %168, %c0_i4 : i4
    %170 = sv.wire {hw.verilogName = "_GEN_21"} : !hw.inout<i1>
    sv.assign %170, %169 : i1
    %171 = sv.read_inout %166 : !hw.inout<i7>
    %172 = comb.extract %171 from 0 : (i7) -> i3
    %173 = sv.read_inout %166 : !hw.inout<i7>
    %174 = comb.extract %173 from 4 : (i7) -> i3
    %175 = sv.read_inout %170 : !hw.inout<i1>
    %176 = comb.mux %175, %172, %174 : i3
    %177 = sv.wire {hw.verilogName = "_GEN_22"} : !hw.inout<i3>
    sv.assign %177, %176 : i3
    %178 = sv.read_inout %177 : !hw.inout<i3>
    %179 = comb.extract %178 from 1 : (i3) -> i2
    %180 = comb.icmp eq %179, %c0_i2 : i2
    %181 = sv.wire {hw.verilogName = "_GEN_23"} : !hw.inout<i1>
    sv.assign %181, %180 : i1
    %182 = sv.read_inout %177 : !hw.inout<i3>
    %183 = comb.extract %182 from 0 : (i3) -> i1
    %184 = sv.read_inout %177 : !hw.inout<i3>
    %185 = comb.extract %184 from 2 : (i3) -> i1
    %186 = sv.read_inout %181 : !hw.inout<i1>
    %187 = comb.mux %186, %183, %185 : i1
    %188 = comb.xor %187, %true : i1
    %189 = sv.wire {hw.verilogName = "_GEN_24"} : !hw.inout<i1>
    sv.assign %189, %188 : i1
    %190 = sv.read_inout %143 : !hw.inout<i18>
    %191 = comb.extract %190 from 0 : (i18) -> i1
    %192 = comb.concat %191, %c0_i16 : i1, i16
    %193 = sv.read_inout %143 : !hw.inout<i18>
    %194 = comb.extract %193 from 0 : (i18) -> i17
    %195 = sv.read_inout %147 : !hw.inout<i1>
    %196 = comb.mux %195, %192, %194 : i17
    %197 = sv.wire {hw.verilogName = "_GEN_25"} : !hw.inout<i17>
    sv.assign %197, %196 : i17
    %198 = sv.read_inout %197 : !hw.inout<i17>
    %199 = comb.extract %198 from 0 : (i17) -> i9
    %200 = comb.concat %199, %c0_i8 : i9, i8
    %201 = sv.read_inout %159 : !hw.inout<i1>
    %202 = sv.read_inout %197 : !hw.inout<i17>
    %203 = comb.mux %201, %200, %202 : i17
    %204 = sv.wire {hw.verilogName = "_GEN_26"} : !hw.inout<i17>
    sv.assign %204, %203 : i17
    %205 = sv.read_inout %204 : !hw.inout<i17>
    %206 = comb.extract %205 from 0 : (i17) -> i13
    %207 = comb.concat %206, %c0_i4 : i13, i4
    %208 = sv.read_inout %170 : !hw.inout<i1>
    %209 = sv.read_inout %204 : !hw.inout<i17>
    %210 = comb.mux %208, %207, %209 : i17
    %211 = sv.wire {hw.verilogName = "_GEN_27"} : !hw.inout<i17>
    sv.assign %211, %210 : i17
    %212 = sv.read_inout %211 : !hw.inout<i17>
    %213 = comb.extract %212 from 0 : (i17) -> i15
    %214 = comb.concat %213, %c0_i2 : i15, i2
    %215 = sv.read_inout %181 : !hw.inout<i1>
    %216 = sv.read_inout %211 : !hw.inout<i17>
    %217 = comb.mux %215, %214, %216 : i17
    %218 = sv.wire {hw.verilogName = "_GEN_28"} : !hw.inout<i17>
    sv.assign %218, %217 : i17
    %219 = sv.read_inout %218 : !hw.inout<i17>
    %220 = comb.extract %219 from 0 : (i17) -> i16
    %221 = comb.concat %220, %false : i16, i1
    %222 = sv.read_inout %189 : !hw.inout<i1>
    %223 = sv.read_inout %218 : !hw.inout<i17>
    %224 = comb.mux %222, %221, %223 : i17
    %225 = sv.read_inout %147 : !hw.inout<i1>
    %226 = sv.read_inout %159 : !hw.inout<i1>
    %227 = sv.read_inout %170 : !hw.inout<i1>
    %228 = sv.read_inout %181 : !hw.inout<i1>
    %229 = sv.read_inout %189 : !hw.inout<i1>
    %230 = comb.concat %c0_i5, %225, %226, %227, %228, %229 : i5, i1, i1, i1, i1, i1
    %231 = comb.sub %c11_i10, %230 : i10
    %232 = comb.add %231, %c127_i10 : i10
    %233 = sv.wire {hw.verilogName = "_GEN_29"} : !hw.inout<i10>
    sv.assign %233, %232 : i10
    %234 = comb.concat %224, %c0_i6 : i17, i6
    %235 = sv.read_inout %233 : !hw.inout<i10>
    %236 = comb.icmp slt %235, %c1_i10 : i10
    %237 = sv.wire {hw.verilogName = "_GEN_30"} : !hw.inout<i1>
    sv.assign %237, %236 : i1
    %238 = sv.read_inout %233 : !hw.inout<i10>
    %239 = comb.icmp sgt %238, %c254_i10 : i10
    %240 = sv.wire {hw.verilogName = "_GEN_31"} : !hw.inout<i1>
    sv.assign %240, %239 : i1
    %241 = sv.read_inout %233 : !hw.inout<i10>
    %242 = comb.extract %241 from 0 : (i10) -> i8
    %243 = sv.read_inout %135 : !hw.inout<i1>
    %244 = sv.read_inout %237 : !hw.inout<i1>
    %245 = comb.or %244, %243 : i1
    %246 = comb.mux %245, %c0_i8, %242 : i8
    %247 = sv.read_inout %240 : !hw.inout<i1>
    %248 = comb.mux %247, %c-1_i8, %246 : i8
    %249 = sv.read_inout %135 : !hw.inout<i1>
    %250 = sv.read_inout %237 : !hw.inout<i1>
    %251 = sv.read_inout %240 : !hw.inout<i1>
    %252 = comb.or %249, %251 : i1
    %253 = comb.or %250, %252 : i1
    %254 = comb.mux %253, %c0_i23, %234 : i23
    %255 = comb.concat %137, %248, %254 : i1, i8, i23
    %256 = sv.read_inout %2 : !hw.inout<i1>
    %257 = comb.mux %256, %c2143289344_i32, %255 : i32
    hw.output %257 : i32
  }
}

