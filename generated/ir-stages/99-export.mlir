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
    %0 = sv.reg {hw.verilogName = "_GEN"} : !hw.inout<i17> 
    %1 = sv.reg {hw.verilogName = "_GEN_0"} : !hw.inout<i1> 
    %c0_i15 = hw.constant 0 : i15
    %c0_i63 = hw.constant 0 : i63
    %c2143289344_i32 = hw.constant 2143289344 : i32
    %c1_i10 = hw.constant 1 : i10
    %c254_i10 = hw.constant 254 : i10
    %c0_i23 = hw.constant 0 : i23
    %c127_i10 = hw.constant 127 : i10
    %c9_i10 = hw.constant 9 : i10
    %c0_i6 = hw.constant 0 : i6
    %c1_i16 = hw.constant 1 : i16
    %c-1_i16 = hw.constant -1 : i16
    %c0_i17 = hw.constant 0 : i17
    %c11_i9 = hw.constant 11 : i9
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %c0_i16 = hw.constant 0 : i16
    %c0_i24 = hw.constant 0 : i24
    %false = hw.constant false
    %c1_i8 = hw.constant 1 : i8
    %true = hw.constant true
    %c-1_i8 = hw.constant -1 : i8
    %c0_i8 = hw.constant 0 : i8
    %2 = comb.extract %x from 31 : (i32) -> i1
    %3 = comb.extract %x from 23 : (i32) -> i8
    %4 = comb.extract %x from 0 : (i32) -> i23
    %5 = comb.icmp eq %3, %c0_i8 : i8
    %6 = sv.wire {hw.verilogName = "_GEN_1"} : !hw.inout<i1>
    sv.assign %6, %5 : i1
    %7 = comb.icmp eq %3, %c-1_i8 : i8
    %8 = sv.read_inout %6 : !hw.inout<i1>
    %9 = comb.xor %8, %true : i1
    %10 = sv.read_inout %6 : !hw.inout<i1>
    %11 = comb.mux %10, %c1_i8, %3 : i8
    %12 = comb.extract %y from 31 : (i32) -> i1
    %13 = comb.extract %y from 23 : (i32) -> i8
    %14 = comb.extract %y from 0 : (i32) -> i23
    %15 = comb.icmp eq %13, %c0_i8 : i8
    %16 = sv.wire {hw.verilogName = "_GEN_2"} : !hw.inout<i1>
    sv.assign %16, %15 : i1
    %17 = comb.icmp eq %13, %c-1_i8 : i8
    %18 = sv.read_inout %16 : !hw.inout<i1>
    %19 = comb.xor %18, %true : i1
    %20 = sv.read_inout %16 : !hw.inout<i1>
    %21 = comb.mux %20, %c1_i8, %13 : i8
    %22 = comb.xor %2, %12 : i1
    %23 = sv.wire {hw.verilogName = "_GEN_3"} : !hw.inout<i1>
    sv.assign %23, %22 : i1
    %24 = comb.concat %c0_i24, %9, %4 : i24, i1, i23
    %25 = comb.concat %c0_i24, %19, %14 : i24, i1, i23
    %26 = comb.mul %24, %25 : i48
    %27 = comb.concat %false, %21 : i1, i8
    %28 = comb.concat %false, %11 : i1, i8
    %29 = sv.read_inout %23 : !hw.inout<i1>
    %30 = comb.replicate %29 : (i1) -> i48
    %31 = comb.xor %30, %26 : i48
    %c247_i9 = hw.constant 247 : i9
    %32 = comb.sub %27, %c247_i9 : i9
    %33 = comb.add %28, %32 : i9
    %34 = sv.wire {hw.verilogName = "_GEN_4"} : !hw.inout<i9>
    sv.assign %34, %33 : i9
    %35 = sv.read_inout %34 : !hw.inout<i9>
    %36 = comb.extract %35 from 8 : (i9) -> i1
    %37 = comb.concat %c0_i15, %31 : i15, i48
    %38 = sv.read_inout %34 : !hw.inout<i9>
    %39 = comb.extract %38 from 7 : (i9) -> i1
    %40 = sv.read_inout %34 : !hw.inout<i9>
    %41 = comb.extract %40 from 6 : (i9) -> i1
    %42 = comb.or %39, %36 : i1
    %43 = comb.or %41, %42 : i1
    %44 = comb.mux %43, %c0_i63, %37 : i63
    %45 = sv.wire {hw.verilogName = "_GEN_5"} : !hw.inout<i63>
    sv.assign %45, %44 : i63
    %46 = sv.read_inout %34 : !hw.inout<i9>
    %47 = comb.extract %46 from 5 : (i9) -> i1
    %48 = sv.read_inout %45 : !hw.inout<i63>
    %49 = comb.extract %48 from 0 : (i63) -> i31
    %50 = comb.concat %49, %c0_i16 : i31, i16
    %51 = sv.read_inout %45 : !hw.inout<i63>
    %52 = comb.extract %51 from 16 : (i63) -> i47
    %53 = comb.mux %47, %50, %52 : i47
    %54 = sv.wire {hw.verilogName = "_GEN_6"} : !hw.inout<i47>
    sv.assign %54, %53 : i47
    %55 = sv.read_inout %34 : !hw.inout<i9>
    %56 = comb.extract %55 from 4 : (i9) -> i1
    %57 = sv.read_inout %54 : !hw.inout<i47>
    %58 = comb.extract %57 from 0 : (i47) -> i31
    %59 = sv.read_inout %54 : !hw.inout<i47>
    %60 = comb.extract %59 from 16 : (i47) -> i31
    %61 = comb.mux %56, %58, %60 : i31
    %62 = sv.wire {hw.verilogName = "_GEN_7"} : !hw.inout<i31>
    sv.assign %62, %61 : i31
    %63 = sv.read_inout %34 : !hw.inout<i9>
    %64 = comb.extract %63 from 3 : (i9) -> i1
    %65 = sv.read_inout %62 : !hw.inout<i31>
    %66 = comb.extract %65 from 0 : (i31) -> i23
    %67 = sv.read_inout %62 : !hw.inout<i31>
    %68 = comb.extract %67 from 8 : (i31) -> i23
    %69 = comb.mux %64, %66, %68 : i23
    %70 = sv.wire {hw.verilogName = "_GEN_8"} : !hw.inout<i23>
    sv.assign %70, %69 : i23
    %71 = sv.read_inout %34 : !hw.inout<i9>
    %72 = comb.extract %71 from 2 : (i9) -> i1
    %73 = sv.read_inout %70 : !hw.inout<i23>
    %74 = comb.extract %73 from 0 : (i23) -> i19
    %75 = sv.read_inout %70 : !hw.inout<i23>
    %76 = comb.extract %75 from 4 : (i23) -> i19
    %77 = comb.mux %72, %74, %76 : i19
    %78 = sv.wire {hw.verilogName = "_GEN_9"} : !hw.inout<i19>
    sv.assign %78, %77 : i19
    %79 = sv.read_inout %34 : !hw.inout<i9>
    %80 = comb.extract %79 from 1 : (i9) -> i1
    %81 = sv.read_inout %78 : !hw.inout<i19>
    %82 = comb.extract %81 from 0 : (i19) -> i17
    %83 = sv.read_inout %78 : !hw.inout<i19>
    %84 = comb.extract %83 from 2 : (i19) -> i17
    %85 = comb.mux %80, %82, %84 : i17
    %86 = sv.wire {hw.verilogName = "_GEN_10"} : !hw.inout<i17>
    sv.assign %86, %85 : i17
    %87 = sv.read_inout %34 : !hw.inout<i9>
    %88 = comb.extract %87 from 0 : (i9) -> i1
    %89 = sv.read_inout %86 : !hw.inout<i17>
    %90 = comb.extract %89 from 0 : (i17) -> i16
    %91 = sv.read_inout %86 : !hw.inout<i17>
    %92 = comb.extract %91 from 1 : (i17) -> i16
    %93 = comb.mux %88, %90, %92 : i16
    %94 = sv.read_inout %34 : !hw.inout<i9>
    %95 = comb.icmp sgt %94, %c11_i9 : i9
    %96 = comb.mux %36, %c0_i16, %93 : i16
    %97 = comb.or %95, %7 : i1
    %98 = sv.read_inout %1 : !hw.inout<i1>
    %99 = comb.or %17, %98 : i1
    %100 = comb.or %97, %99 : i1
    sv.alwaysff(posedge %clk) {
      sv.passign %1, %100 : i1
    }(syncreset : posedge %reset) {
      sv.passign %1, %false : i1
    }
    %101 = comb.concat %false, %96 : i1, i16
    %102 = sv.read_inout %23 : !hw.inout<i1>
    %103 = comb.concat %c0_i16, %102 : i16, i1
    %104 = sv.read_inout %0 : !hw.inout<i17>
    %105 = comb.extract %104 from 0 : (i17) -> i16
    %106 = comb.concat %false, %105 : i1, i16
    %107 = comb.add %101, %103 : i17
    %108 = comb.add %106, %107 : i17
    sv.alwaysff(posedge %clk) {
      sv.passign %0, %108 : i17
    }(syncreset : posedge %reset) {
      sv.passign %0, %c0_i17 : i17
    }
    %109 = comb.icmp eq %105, %c0_i16 : i16
    %110 = sv.wire {hw.verilogName = "_GEN_11"} : !hw.inout<i1>
    sv.assign %110, %109 : i1
    %111 = sv.read_inout %0 : !hw.inout<i17>
    %112 = comb.extract %111 from 15 : (i17) -> i1
    %113 = comb.xor %105, %c-1_i16 : i16
    %114 = comb.add %113, %c1_i16 : i16
    %115 = comb.mux %112, %114, %105 : i16
    %116 = sv.wire {hw.verilogName = "_GEN_12"} : !hw.inout<i16>
    sv.assign %116, %115 : i16
    %117 = sv.read_inout %116 : !hw.inout<i16>
    %118 = comb.extract %117 from 8 : (i16) -> i8
    %119 = comb.icmp eq %118, %c0_i8 : i8
    %120 = sv.wire {hw.verilogName = "_GEN_13"} : !hw.inout<i1>
    sv.assign %120, %119 : i1
    %121 = sv.read_inout %116 : !hw.inout<i16>
    %122 = comb.extract %121 from 1 : (i16) -> i7
    %123 = sv.read_inout %116 : !hw.inout<i16>
    %124 = comb.extract %123 from 9 : (i16) -> i7
    %125 = sv.read_inout %120 : !hw.inout<i1>
    %126 = comb.mux %125, %122, %124 : i7
    %127 = sv.wire {hw.verilogName = "_GEN_14"} : !hw.inout<i7>
    sv.assign %127, %126 : i7
    %128 = sv.read_inout %127 : !hw.inout<i7>
    %129 = comb.extract %128 from 3 : (i7) -> i4
    %130 = comb.icmp eq %129, %c0_i4 : i4
    %131 = sv.wire {hw.verilogName = "_GEN_15"} : !hw.inout<i1>
    sv.assign %131, %130 : i1
    %132 = sv.read_inout %127 : !hw.inout<i7>
    %133 = comb.extract %132 from 0 : (i7) -> i3
    %134 = sv.read_inout %127 : !hw.inout<i7>
    %135 = comb.extract %134 from 4 : (i7) -> i3
    %136 = sv.read_inout %131 : !hw.inout<i1>
    %137 = comb.mux %136, %133, %135 : i3
    %138 = sv.wire {hw.verilogName = "_GEN_16"} : !hw.inout<i3>
    sv.assign %138, %137 : i3
    %139 = sv.read_inout %138 : !hw.inout<i3>
    %140 = comb.extract %139 from 1 : (i3) -> i2
    %141 = comb.icmp eq %140, %c0_i2 : i2
    %142 = sv.wire {hw.verilogName = "_GEN_17"} : !hw.inout<i1>
    sv.assign %142, %141 : i1
    %143 = sv.read_inout %138 : !hw.inout<i3>
    %144 = comb.extract %143 from 0 : (i3) -> i1
    %145 = sv.read_inout %138 : !hw.inout<i3>
    %146 = comb.extract %145 from 2 : (i3) -> i1
    %147 = sv.read_inout %142 : !hw.inout<i1>
    %148 = comb.mux %147, %144, %146 : i1
    %149 = comb.xor %148, %true : i1
    %150 = sv.wire {hw.verilogName = "_GEN_18"} : !hw.inout<i1>
    sv.assign %150, %149 : i1
    %151 = sv.read_inout %116 : !hw.inout<i16>
    %152 = comb.extract %151 from 0 : (i16) -> i7
    %153 = comb.concat %152, %c0_i8 : i7, i8
    %154 = sv.read_inout %116 : !hw.inout<i16>
    %155 = comb.extract %154 from 0 : (i16) -> i15
    %156 = sv.read_inout %120 : !hw.inout<i1>
    %157 = comb.mux %156, %153, %155 : i15
    %158 = sv.wire {hw.verilogName = "_GEN_19"} : !hw.inout<i15>
    sv.assign %158, %157 : i15
    %159 = sv.read_inout %158 : !hw.inout<i15>
    %160 = comb.extract %159 from 0 : (i15) -> i11
    %161 = comb.concat %160, %c0_i4 : i11, i4
    %162 = sv.read_inout %131 : !hw.inout<i1>
    %163 = sv.read_inout %158 : !hw.inout<i15>
    %164 = comb.mux %162, %161, %163 : i15
    %165 = sv.wire {hw.verilogName = "_GEN_20"} : !hw.inout<i15>
    sv.assign %165, %164 : i15
    %166 = sv.read_inout %165 : !hw.inout<i15>
    %167 = comb.extract %166 from 0 : (i15) -> i13
    %168 = comb.concat %167, %c0_i2 : i13, i2
    %169 = sv.read_inout %142 : !hw.inout<i1>
    %170 = sv.read_inout %165 : !hw.inout<i15>
    %171 = comb.mux %169, %168, %170 : i15
    %172 = sv.wire {hw.verilogName = "_GEN_21"} : !hw.inout<i15>
    sv.assign %172, %171 : i15
    %173 = sv.read_inout %172 : !hw.inout<i15>
    %174 = comb.extract %173 from 0 : (i15) -> i14
    %175 = comb.concat %174, %false : i14, i1
    %176 = sv.read_inout %150 : !hw.inout<i1>
    %177 = sv.read_inout %172 : !hw.inout<i15>
    %178 = comb.mux %176, %175, %177 : i15
    %179 = sv.read_inout %120 : !hw.inout<i1>
    %180 = sv.read_inout %131 : !hw.inout<i1>
    %181 = sv.read_inout %142 : !hw.inout<i1>
    %182 = sv.read_inout %150 : !hw.inout<i1>
    %183 = comb.concat %c0_i6, %179, %180, %181, %182 : i6, i1, i1, i1, i1
    %184 = comb.sub %c9_i10, %183 : i10
    %185 = comb.add %184, %c127_i10 : i10
    %186 = sv.wire {hw.verilogName = "_GEN_22"} : !hw.inout<i10>
    sv.assign %186, %185 : i10
    %187 = comb.concat %178, %c0_i8 : i15, i8
    %188 = sv.read_inout %186 : !hw.inout<i10>
    %189 = comb.icmp slt %188, %c1_i10 : i10
    %190 = sv.wire {hw.verilogName = "_GEN_23"} : !hw.inout<i1>
    sv.assign %190, %189 : i1
    %191 = sv.read_inout %186 : !hw.inout<i10>
    %192 = comb.icmp sgt %191, %c254_i10 : i10
    %193 = sv.wire {hw.verilogName = "_GEN_24"} : !hw.inout<i1>
    sv.assign %193, %192 : i1
    %194 = sv.read_inout %186 : !hw.inout<i10>
    %195 = comb.extract %194 from 0 : (i10) -> i8
    %196 = sv.read_inout %110 : !hw.inout<i1>
    %197 = sv.read_inout %190 : !hw.inout<i1>
    %198 = comb.or %197, %196 : i1
    %199 = comb.mux %198, %c0_i8, %195 : i8
    %200 = sv.read_inout %193 : !hw.inout<i1>
    %201 = comb.mux %200, %c-1_i8, %199 : i8
    %202 = sv.read_inout %110 : !hw.inout<i1>
    %203 = sv.read_inout %190 : !hw.inout<i1>
    %204 = sv.read_inout %193 : !hw.inout<i1>
    %205 = comb.or %202, %204 : i1
    %206 = comb.or %203, %205 : i1
    %207 = comb.mux %206, %c0_i23, %187 : i23
    %208 = comb.concat %112, %201, %207 : i1, i8, i23
    %209 = sv.read_inout %1 : !hw.inout<i1>
    %210 = comb.mux %209, %c2143289344_i32, %208 : i32
    hw.output %210 : i32
  }
}

