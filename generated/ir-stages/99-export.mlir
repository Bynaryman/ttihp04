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
    %0 = sv.reg {hw.verilogName = "_GEN"} : !hw.inout<i8> 
    %1 = sv.reg {hw.verilogName = "_GEN_0"} : !hw.inout<i17> 
    %2 = sv.reg {hw.verilogName = "_GEN_1"} : !hw.inout<i17> 
    %3 = sv.reg {hw.verilogName = "_GEN_2"} : !hw.inout<i1> 
    %c0_i38 = hw.constant 0 : i38
    %c0_i86 = hw.constant 0 : i86
    %c2143289344_i32 = hw.constant 2143289344 : i32
    %c1_i10 = hw.constant 1 : i10
    %c1_i2 = hw.constant 1 : i2
    %c254_i10 = hw.constant 254 : i10
    %c0_i23 = hw.constant 0 : i23
    %c0_i9 = hw.constant 0 : i9
    %c127_i10 = hw.constant 127 : i10
    %c15_i10 = hw.constant 15 : i10
    %c1_i39 = hw.constant 1 : i39
    %c-1_i39 = hw.constant -1 : i39
    %c0_i13 = hw.constant 0 : i13
    %c0_i12 = hw.constant 0 : i12
    %c0_i7 = hw.constant 0 : i7
    %c0_i17 = hw.constant 0 : i17
    %c0_i39 = hw.constant 0 : i39
    %c33_i9 = hw.constant 33 : i9
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
    %c0_i32 = hw.constant 0 : i32
    %4 = comb.extract %x from 31 : (i32) -> i1
    %5 = comb.extract %x from 23 : (i32) -> i8
    %6 = comb.extract %x from 0 : (i32) -> i23
    %7 = comb.icmp eq %5, %c0_i8 : i8
    %8 = sv.wire {hw.verilogName = "_GEN_3"} : !hw.inout<i1>
    sv.assign %8, %7 : i1
    %9 = comb.icmp eq %5, %c-1_i8 : i8
    %10 = sv.read_inout %8 : !hw.inout<i1>
    %11 = comb.xor %10, %true : i1
    %12 = sv.read_inout %8 : !hw.inout<i1>
    %13 = comb.mux %12, %c1_i8, %5 : i8
    %14 = comb.extract %y from 31 : (i32) -> i1
    %15 = comb.extract %y from 23 : (i32) -> i8
    %16 = comb.extract %y from 0 : (i32) -> i23
    %17 = comb.icmp eq %15, %c0_i8 : i8
    %18 = sv.wire {hw.verilogName = "_GEN_4"} : !hw.inout<i1>
    sv.assign %18, %17 : i1
    %19 = comb.icmp eq %15, %c-1_i8 : i8
    %20 = sv.read_inout %18 : !hw.inout<i1>
    %21 = comb.xor %20, %true : i1
    %22 = sv.read_inout %18 : !hw.inout<i1>
    %23 = comb.mux %22, %c1_i8, %15 : i8
    %24 = comb.xor %4, %14 : i1
    %25 = sv.wire {hw.verilogName = "_GEN_5"} : !hw.inout<i1>
    sv.assign %25, %24 : i1
    %26 = comb.concat %c0_i24, %11, %6 : i24, i1, i23
    %27 = comb.concat %c0_i24, %21, %16 : i24, i1, i23
    %28 = comb.mul %26, %27 : i48
    %29 = comb.concat %false, %23 : i1, i8
    %30 = comb.concat %false, %13 : i1, i8
    %31 = sv.read_inout %25 : !hw.inout<i1>
    %32 = comb.replicate %31 : (i1) -> i48
    %33 = comb.xor %32, %28 : i48
    %c230_i9 = hw.constant 230 : i9
    %34 = comb.sub %29, %c230_i9 : i9
    %35 = comb.add %30, %34 : i9
    %36 = sv.wire {hw.verilogName = "_GEN_6"} : !hw.inout<i9>
    sv.assign %36, %35 : i9
    %37 = sv.read_inout %36 : !hw.inout<i9>
    %38 = comb.extract %37 from 8 : (i9) -> i1
    %39 = comb.concat %c0_i38, %33 : i38, i48
    %40 = sv.read_inout %36 : !hw.inout<i9>
    %41 = comb.extract %40 from 7 : (i9) -> i1
    %42 = comb.or %41, %38 : i1
    %43 = comb.mux %42, %c0_i86, %39 : i86
    %44 = sv.wire {hw.verilogName = "_GEN_7"} : !hw.inout<i86>
    sv.assign %44, %43 : i86
    %45 = sv.read_inout %36 : !hw.inout<i9>
    %46 = comb.extract %45 from 6 : (i9) -> i1
    %47 = sv.read_inout %44 : !hw.inout<i86>
    %48 = comb.extract %47 from 0 : (i86) -> i22
    %49 = comb.concat %48, %c0_i64 : i22, i64
    %50 = sv.read_inout %44 : !hw.inout<i86>
    %51 = comb.mux %46, %49, %50 : i86
    %52 = sv.wire {hw.verilogName = "_GEN_8"} : !hw.inout<i86>
    sv.assign %52, %51 : i86
    %53 = sv.read_inout %36 : !hw.inout<i9>
    %54 = comb.extract %53 from 5 : (i9) -> i1
    %55 = sv.read_inout %52 : !hw.inout<i86>
    %56 = comb.extract %55 from 0 : (i86) -> i54
    %57 = comb.concat %56, %c0_i16 : i54, i16
    %58 = sv.read_inout %52 : !hw.inout<i86>
    %59 = comb.extract %58 from 16 : (i86) -> i70
    %60 = comb.mux %54, %57, %59 : i70
    %61 = sv.wire {hw.verilogName = "_GEN_9"} : !hw.inout<i70>
    sv.assign %61, %60 : i70
    %62 = sv.read_inout %36 : !hw.inout<i9>
    %63 = comb.extract %62 from 4 : (i9) -> i1
    %64 = sv.read_inout %61 : !hw.inout<i70>
    %65 = comb.extract %64 from 0 : (i70) -> i54
    %66 = sv.read_inout %61 : !hw.inout<i70>
    %67 = comb.extract %66 from 16 : (i70) -> i54
    %68 = comb.mux %63, %65, %67 : i54
    %69 = sv.wire {hw.verilogName = "_GEN_10"} : !hw.inout<i54>
    sv.assign %69, %68 : i54
    %70 = sv.read_inout %36 : !hw.inout<i9>
    %71 = comb.extract %70 from 3 : (i9) -> i1
    %72 = sv.read_inout %69 : !hw.inout<i54>
    %73 = comb.extract %72 from 0 : (i54) -> i46
    %74 = sv.read_inout %69 : !hw.inout<i54>
    %75 = comb.extract %74 from 8 : (i54) -> i46
    %76 = comb.mux %71, %73, %75 : i46
    %77 = sv.wire {hw.verilogName = "_GEN_11"} : !hw.inout<i46>
    sv.assign %77, %76 : i46
    %78 = sv.read_inout %36 : !hw.inout<i9>
    %79 = comb.extract %78 from 2 : (i9) -> i1
    %80 = sv.read_inout %77 : !hw.inout<i46>
    %81 = comb.extract %80 from 0 : (i46) -> i42
    %82 = sv.read_inout %77 : !hw.inout<i46>
    %83 = comb.extract %82 from 4 : (i46) -> i42
    %84 = comb.mux %79, %81, %83 : i42
    %85 = sv.wire {hw.verilogName = "_GEN_12"} : !hw.inout<i42>
    sv.assign %85, %84 : i42
    %86 = sv.read_inout %36 : !hw.inout<i9>
    %87 = comb.extract %86 from 1 : (i9) -> i1
    %88 = sv.read_inout %85 : !hw.inout<i42>
    %89 = comb.extract %88 from 0 : (i42) -> i40
    %90 = sv.read_inout %85 : !hw.inout<i42>
    %91 = comb.extract %90 from 2 : (i42) -> i40
    %92 = comb.mux %87, %89, %91 : i40
    %93 = sv.wire {hw.verilogName = "_GEN_13"} : !hw.inout<i40>
    sv.assign %93, %92 : i40
    %94 = sv.read_inout %36 : !hw.inout<i9>
    %95 = comb.extract %94 from 0 : (i9) -> i1
    %96 = sv.read_inout %93 : !hw.inout<i40>
    %97 = comb.extract %96 from 0 : (i40) -> i39
    %98 = sv.read_inout %93 : !hw.inout<i40>
    %99 = comb.extract %98 from 1 : (i40) -> i39
    %100 = comb.mux %95, %97, %99 : i39
    %101 = sv.read_inout %36 : !hw.inout<i9>
    %102 = comb.icmp sgt %101, %c33_i9 : i9
    %103 = comb.mux %38, %c0_i39, %100 : i39
    %104 = sv.wire {hw.verilogName = "_GEN_14"} : !hw.inout<i39>
    sv.assign %104, %103 : i39
    %105 = comb.or %102, %9 : i1
    %106 = sv.read_inout %3 : !hw.inout<i1>
    %107 = comb.or %19, %106 : i1
    %108 = comb.or %105, %107 : i1
    sv.alwaysff(posedge %clk) {
      sv.passign %3, %108 : i1
    }(syncreset : posedge %reset) {
      sv.passign %3, %false : i1
    }
    %109 = sv.read_inout %104 : !hw.inout<i39>
    %110 = comb.extract %109 from 0 : (i39) -> i16
    %111 = comb.concat %false, %110 : i1, i16
    %112 = sv.read_inout %25 : !hw.inout<i1>
    %113 = comb.concat %c0_i16, %112 : i16, i1
    %114 = sv.read_inout %2 : !hw.inout<i17>
    %115 = comb.extract %114 from 0 : (i17) -> i16
    %116 = comb.concat %false, %115 : i1, i16
    %117 = comb.add %111, %113 : i17
    %118 = comb.add %116, %117 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %2, %118 : i17
    }(syncreset : posedge %reset) {
      sv.passign %2, %c0_i17 : i17
    }
    %119 = sv.read_inout %2 : !hw.inout<i17>
    %120 = comb.extract %119 from 16 : (i17) -> i1
    %121 = sv.read_inout %104 : !hw.inout<i39>
    %122 = comb.extract %121 from 16 : (i39) -> i16
    %123 = comb.concat %false, %122 : i1, i16
    %124 = comb.concat %c0_i16, %120 : i16, i1
    %125 = sv.read_inout %1 : !hw.inout<i17>
    %126 = comb.extract %125 from 0 : (i17) -> i16
    %127 = comb.concat %false, %126 : i1, i16
    %128 = comb.add %123, %124 : i17
    %129 = comb.add %127, %128 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %1, %129 : i17
    }(syncreset : posedge %reset) {
      sv.passign %1, %c0_i17 : i17
    }
    %130 = sv.read_inout %1 : !hw.inout<i17>
    %131 = comb.extract %130 from 16 : (i17) -> i1
    %132 = sv.read_inout %104 : !hw.inout<i39>
    %133 = comb.extract %132 from 32 : (i39) -> i7
    %134 = comb.concat %false, %133 : i1, i7
    %135 = comb.concat %c0_i7, %131 : i7, i1
    %136 = sv.read_inout %0 : !hw.inout<i8>
    %137 = comb.extract %136 from 0 : (i8) -> i7
    %138 = comb.concat %false, %137 : i1, i7
    %139 = comb.add %134, %135 : i8
    %140 = comb.add %138, %139 : i8
    sv.alwaysff(posedge %clk) {
      sv.passign %0, %140 : i8
    }(syncreset : posedge %reset) {
      sv.passign %0, %c0_i8 : i8
    }
    %141 = comb.concat %137, %126, %115 : i7, i16, i16
    %142 = comb.concat %c0_i12, %131, %c0_i12, %120, %c0_i13 : i12, i1, i12, i1, i13
    %143 = comb.add %141, %142 : i39
    %144 = sv.wire {hw.verilogName = "_GEN_15"} : !hw.inout<i39>
    sv.assign %144, %143 : i39
    %145 = sv.read_inout %144 : !hw.inout<i39>
    %146 = comb.icmp eq %145, %c0_i39 : i39
    %147 = sv.wire {hw.verilogName = "_GEN_16"} : !hw.inout<i1>
    sv.assign %147, %146 : i1
    %148 = sv.read_inout %144 : !hw.inout<i39>
    %149 = comb.extract %148 from 38 : (i39) -> i1
    %150 = sv.read_inout %144 : !hw.inout<i39>
    %151 = comb.xor %150, %c-1_i39 : i39
    %152 = comb.add %151, %c1_i39 : i39
    %153 = sv.read_inout %144 : !hw.inout<i39>
    %154 = comb.mux %149, %152, %153 : i39
    %155 = sv.wire {hw.verilogName = "_GEN_17"} : !hw.inout<i39>
    sv.assign %155, %154 : i39
    %156 = sv.read_inout %155 : !hw.inout<i39>
    %157 = comb.extract %156 from 7 : (i39) -> i32
    %158 = comb.icmp eq %157, %c0_i32 : i32
    %159 = sv.wire {hw.verilogName = "_GEN_18"} : !hw.inout<i1>
    sv.assign %159, %158 : i1
    %160 = sv.read_inout %155 : !hw.inout<i39>
    %161 = comb.extract %160 from 0 : (i39) -> i7
    %162 = comb.concat %161, %c0_i24 : i7, i24
    %163 = sv.read_inout %155 : !hw.inout<i39>
    %164 = comb.extract %163 from 8 : (i39) -> i31
    %165 = sv.read_inout %159 : !hw.inout<i1>
    %166 = comb.mux %165, %162, %164 : i31
    %167 = sv.wire {hw.verilogName = "_GEN_19"} : !hw.inout<i31>
    sv.assign %167, %166 : i31
    %168 = sv.read_inout %167 : !hw.inout<i31>
    %169 = comb.extract %168 from 15 : (i31) -> i16
    %170 = comb.icmp eq %169, %c0_i16 : i16
    %171 = sv.wire {hw.verilogName = "_GEN_20"} : !hw.inout<i1>
    sv.assign %171, %170 : i1
    %172 = sv.read_inout %167 : !hw.inout<i31>
    %173 = comb.extract %172 from 0 : (i31) -> i15
    %174 = sv.read_inout %167 : !hw.inout<i31>
    %175 = comb.extract %174 from 16 : (i31) -> i15
    %176 = sv.read_inout %171 : !hw.inout<i1>
    %177 = comb.mux %176, %173, %175 : i15
    %178 = sv.wire {hw.verilogName = "_GEN_21"} : !hw.inout<i15>
    sv.assign %178, %177 : i15
    %179 = sv.read_inout %178 : !hw.inout<i15>
    %180 = comb.extract %179 from 7 : (i15) -> i8
    %181 = comb.icmp eq %180, %c0_i8 : i8
    %182 = sv.wire {hw.verilogName = "_GEN_22"} : !hw.inout<i1>
    sv.assign %182, %181 : i1
    %183 = sv.read_inout %178 : !hw.inout<i15>
    %184 = comb.extract %183 from 0 : (i15) -> i7
    %185 = sv.read_inout %178 : !hw.inout<i15>
    %186 = comb.extract %185 from 8 : (i15) -> i7
    %187 = sv.read_inout %182 : !hw.inout<i1>
    %188 = comb.mux %187, %184, %186 : i7
    %189 = sv.wire {hw.verilogName = "_GEN_23"} : !hw.inout<i7>
    sv.assign %189, %188 : i7
    %190 = sv.read_inout %189 : !hw.inout<i7>
    %191 = comb.extract %190 from 3 : (i7) -> i4
    %192 = comb.icmp eq %191, %c0_i4 : i4
    %193 = sv.wire {hw.verilogName = "_GEN_24"} : !hw.inout<i1>
    sv.assign %193, %192 : i1
    %194 = sv.read_inout %189 : !hw.inout<i7>
    %195 = comb.extract %194 from 0 : (i7) -> i3
    %196 = sv.read_inout %189 : !hw.inout<i7>
    %197 = comb.extract %196 from 4 : (i7) -> i3
    %198 = sv.read_inout %193 : !hw.inout<i1>
    %199 = comb.mux %198, %195, %197 : i3
    %200 = sv.wire {hw.verilogName = "_GEN_25"} : !hw.inout<i3>
    sv.assign %200, %199 : i3
    %201 = sv.read_inout %200 : !hw.inout<i3>
    %202 = comb.extract %201 from 1 : (i3) -> i2
    %203 = comb.icmp eq %202, %c0_i2 : i2
    %204 = sv.wire {hw.verilogName = "_GEN_26"} : !hw.inout<i1>
    sv.assign %204, %203 : i1
    %205 = sv.read_inout %200 : !hw.inout<i3>
    %206 = comb.extract %205 from 0 : (i3) -> i1
    %207 = sv.read_inout %200 : !hw.inout<i3>
    %208 = comb.extract %207 from 2 : (i3) -> i1
    %209 = sv.read_inout %204 : !hw.inout<i1>
    %210 = comb.mux %209, %206, %208 : i1
    %211 = comb.xor %210, %true : i1
    %212 = sv.wire {hw.verilogName = "_GEN_27"} : !hw.inout<i1>
    sv.assign %212, %211 : i1
    %213 = sv.read_inout %155 : !hw.inout<i39>
    %214 = comb.extract %213 from 0 : (i39) -> i6
    %215 = comb.concat %214, %c0_i32 : i6, i32
    %216 = sv.read_inout %155 : !hw.inout<i39>
    %217 = comb.extract %216 from 0 : (i39) -> i38
    %218 = sv.read_inout %159 : !hw.inout<i1>
    %219 = comb.mux %218, %215, %217 : i38
    %220 = sv.wire {hw.verilogName = "_GEN_28"} : !hw.inout<i38>
    sv.assign %220, %219 : i38
    %221 = sv.read_inout %220 : !hw.inout<i38>
    %222 = comb.extract %221 from 0 : (i38) -> i22
    %223 = comb.concat %222, %c0_i16 : i22, i16
    %224 = sv.read_inout %171 : !hw.inout<i1>
    %225 = sv.read_inout %220 : !hw.inout<i38>
    %226 = comb.mux %224, %223, %225 : i38
    %227 = sv.wire {hw.verilogName = "_GEN_29"} : !hw.inout<i38>
    sv.assign %227, %226 : i38
    %228 = sv.read_inout %227 : !hw.inout<i38>
    %229 = comb.extract %228 from 0 : (i38) -> i30
    %230 = comb.concat %229, %c0_i8 : i30, i8
    %231 = sv.read_inout %182 : !hw.inout<i1>
    %232 = sv.read_inout %227 : !hw.inout<i38>
    %233 = comb.mux %231, %230, %232 : i38
    %234 = sv.wire {hw.verilogName = "_GEN_30"} : !hw.inout<i38>
    sv.assign %234, %233 : i38
    %235 = sv.read_inout %234 : !hw.inout<i38>
    %236 = comb.extract %235 from 0 : (i38) -> i34
    %237 = comb.concat %236, %c0_i4 : i34, i4
    %238 = sv.read_inout %193 : !hw.inout<i1>
    %239 = sv.read_inout %234 : !hw.inout<i38>
    %240 = comb.mux %238, %237, %239 : i38
    %241 = sv.wire {hw.verilogName = "_GEN_31"} : !hw.inout<i38>
    sv.assign %241, %240 : i38
    %242 = sv.read_inout %241 : !hw.inout<i38>
    %243 = comb.extract %242 from 0 : (i38) -> i36
    %244 = comb.concat %243, %c0_i2 : i36, i2
    %245 = sv.read_inout %204 : !hw.inout<i1>
    %246 = sv.read_inout %241 : !hw.inout<i38>
    %247 = comb.mux %245, %244, %246 : i38
    %248 = sv.wire {hw.verilogName = "_GEN_32"} : !hw.inout<i38>
    sv.assign %248, %247 : i38
    %249 = sv.read_inout %248 : !hw.inout<i38>
    %250 = comb.extract %249 from 0 : (i38) -> i37
    %251 = comb.concat %250, %false : i37, i1
    %252 = sv.read_inout %212 : !hw.inout<i1>
    %253 = sv.read_inout %248 : !hw.inout<i38>
    %254 = comb.mux %252, %251, %253 : i38
    %255 = sv.wire {hw.verilogName = "_GEN_33"} : !hw.inout<i38>
    sv.assign %255, %254 : i38
    %256 = sv.read_inout %255 : !hw.inout<i38>
    %257 = comb.extract %256 from 0 : (i38) -> i13
    %258 = comb.icmp ne %257, %c0_i13 : i13
    %259 = sv.read_inout %159 : !hw.inout<i1>
    %260 = sv.read_inout %171 : !hw.inout<i1>
    %261 = sv.read_inout %182 : !hw.inout<i1>
    %262 = sv.read_inout %193 : !hw.inout<i1>
    %263 = sv.read_inout %204 : !hw.inout<i1>
    %264 = sv.read_inout %212 : !hw.inout<i1>
    %265 = comb.concat %c0_i4, %259, %260, %261, %262, %263, %264 : i4, i1, i1, i1, i1, i1, i1
    %266 = comb.sub %c15_i10, %265 : i10
    %267 = sv.read_inout %255 : !hw.inout<i38>
    %268 = comb.extract %267 from 15 : (i38) -> i23
    %269 = sv.read_inout %255 : !hw.inout<i38>
    %270 = comb.extract %269 from 14 : (i38) -> i1
    %271 = sv.read_inout %255 : !hw.inout<i38>
    %272 = comb.extract %271 from 13 : (i38) -> i1
    %273 = sv.read_inout %255 : !hw.inout<i38>
    %274 = comb.extract %273 from 15 : (i38) -> i1
    %275 = comb.or %258, %274 : i1
    %276 = comb.or %272, %275 : i1
    %277 = comb.and %270, %276 : i1
    %278 = comb.concat %c0_i24, %277 : i24, i1
    %279 = comb.concat %c1_i2, %268 : i2, i23
    %280 = comb.add %279, %278 : i25
    %281 = sv.wire {hw.verilogName = "_GEN_34"} : !hw.inout<i25>
    sv.assign %281, %280 : i25
    %282 = sv.read_inout %281 : !hw.inout<i25>
    %283 = comb.extract %282 from 24 : (i25) -> i1
    %284 = sv.read_inout %281 : !hw.inout<i25>
    %285 = comb.extract %284 from 1 : (i25) -> i23
    %286 = sv.read_inout %281 : !hw.inout<i25>
    %287 = comb.extract %286 from 0 : (i25) -> i23
    %288 = comb.mux %283, %285, %287 : i23
    %289 = comb.concat %c0_i9, %283 : i9, i1
    %290 = comb.add %289, %c127_i10 : i10
    %291 = comb.add %266, %290 : i10
    %292 = sv.wire {hw.verilogName = "_GEN_35"} : !hw.inout<i10>
    sv.assign %292, %291 : i10
    %293 = sv.read_inout %292 : !hw.inout<i10>
    %294 = comb.icmp slt %293, %c1_i10 : i10
    %295 = sv.wire {hw.verilogName = "_GEN_36"} : !hw.inout<i1>
    sv.assign %295, %294 : i1
    %296 = sv.read_inout %292 : !hw.inout<i10>
    %297 = comb.icmp sgt %296, %c254_i10 : i10
    %298 = sv.wire {hw.verilogName = "_GEN_37"} : !hw.inout<i1>
    sv.assign %298, %297 : i1
    %299 = sv.read_inout %292 : !hw.inout<i10>
    %300 = comb.extract %299 from 0 : (i10) -> i8
    %301 = sv.read_inout %147 : !hw.inout<i1>
    %302 = sv.read_inout %295 : !hw.inout<i1>
    %303 = comb.or %302, %301 : i1
    %304 = comb.mux %303, %c0_i8, %300 : i8
    %305 = sv.read_inout %298 : !hw.inout<i1>
    %306 = comb.mux %305, %c-1_i8, %304 : i8
    %307 = sv.read_inout %147 : !hw.inout<i1>
    %308 = sv.read_inout %295 : !hw.inout<i1>
    %309 = sv.read_inout %298 : !hw.inout<i1>
    %310 = comb.or %307, %309 : i1
    %311 = comb.or %308, %310 : i1
    %312 = comb.mux %311, %c0_i23, %288 : i23
    %313 = comb.concat %149, %306, %312 : i1, i8, i23
    %314 = sv.read_inout %3 : !hw.inout<i1>
    %315 = comb.mux %314, %c2143289344_i32, %313 : i32
    hw.output %315 : i32
  }
}

