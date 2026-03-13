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
    %1 = sv.reg {hw.verilogName = "_GEN_0"} : !hw.inout<i1> 
    %c0_i12 = hw.constant 0 : i12
    %c0_i60 = hw.constant 0 : i60
    %c0_i16 = hw.constant 0 : i16
    %c2143289344_i32 = hw.constant 2143289344 : i32
    %c1_i10 = hw.constant 1 : i10
    %c0_i11 = hw.constant 0 : i11
    %c254_i10 = hw.constant 254 : i10
    %c0_i23 = hw.constant 0 : i23
    %c127_i10 = hw.constant 127 : i10
    %c6_i10 = hw.constant 6 : i10
    %c0_i6 = hw.constant 0 : i6
    %c1_i13 = hw.constant 1 : i13
    %c-1_i13 = hw.constant -1 : i13
    %c0_i14 = hw.constant 0 : i14
    %c0_i13 = hw.constant 0 : i13
    %c10_i9 = hw.constant 10 : i9
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
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
    %37 = comb.concat %c0_i12, %31 : i12, i48
    %38 = sv.read_inout %34 : !hw.inout<i9>
    %39 = comb.extract %38 from 7 : (i9) -> i1
    %40 = sv.read_inout %34 : !hw.inout<i9>
    %41 = comb.extract %40 from 6 : (i9) -> i1
    %42 = comb.or %39, %36 : i1
    %43 = comb.or %41, %42 : i1
    %44 = comb.mux %43, %c0_i60, %37 : i60
    %45 = sv.wire {hw.verilogName = "_GEN_5"} : !hw.inout<i60>
    sv.assign %45, %44 : i60
    %46 = sv.read_inout %34 : !hw.inout<i9>
    %47 = comb.extract %46 from 5 : (i9) -> i1
    %48 = sv.read_inout %45 : !hw.inout<i60>
    %49 = comb.extract %48 from 0 : (i60) -> i28
    %50 = comb.concat %49, %c0_i16 : i28, i16
    %51 = sv.read_inout %45 : !hw.inout<i60>
    %52 = comb.extract %51 from 16 : (i60) -> i44
    %53 = comb.mux %47, %50, %52 : i44
    %54 = sv.wire {hw.verilogName = "_GEN_6"} : !hw.inout<i44>
    sv.assign %54, %53 : i44
    %55 = sv.read_inout %34 : !hw.inout<i9>
    %56 = comb.extract %55 from 4 : (i9) -> i1
    %57 = sv.read_inout %54 : !hw.inout<i44>
    %58 = comb.extract %57 from 0 : (i44) -> i28
    %59 = sv.read_inout %54 : !hw.inout<i44>
    %60 = comb.extract %59 from 16 : (i44) -> i28
    %61 = comb.mux %56, %58, %60 : i28
    %62 = sv.wire {hw.verilogName = "_GEN_7"} : !hw.inout<i28>
    sv.assign %62, %61 : i28
    %63 = sv.read_inout %34 : !hw.inout<i9>
    %64 = comb.extract %63 from 3 : (i9) -> i1
    %65 = sv.read_inout %62 : !hw.inout<i28>
    %66 = comb.extract %65 from 0 : (i28) -> i20
    %67 = sv.read_inout %62 : !hw.inout<i28>
    %68 = comb.extract %67 from 8 : (i28) -> i20
    %69 = comb.mux %64, %66, %68 : i20
    %70 = sv.wire {hw.verilogName = "_GEN_8"} : !hw.inout<i20>
    sv.assign %70, %69 : i20
    %71 = sv.read_inout %34 : !hw.inout<i9>
    %72 = comb.extract %71 from 2 : (i9) -> i1
    %73 = sv.read_inout %70 : !hw.inout<i20>
    %74 = comb.extract %73 from 0 : (i20) -> i16
    %75 = sv.read_inout %70 : !hw.inout<i20>
    %76 = comb.extract %75 from 4 : (i20) -> i16
    %77 = comb.mux %72, %74, %76 : i16
    %78 = sv.wire {hw.verilogName = "_GEN_9"} : !hw.inout<i16>
    sv.assign %78, %77 : i16
    %79 = sv.read_inout %34 : !hw.inout<i9>
    %80 = comb.extract %79 from 1 : (i9) -> i1
    %81 = sv.read_inout %78 : !hw.inout<i16>
    %82 = comb.extract %81 from 0 : (i16) -> i14
    %83 = sv.read_inout %78 : !hw.inout<i16>
    %84 = comb.extract %83 from 2 : (i16) -> i14
    %85 = comb.mux %80, %82, %84 : i14
    %86 = sv.wire {hw.verilogName = "_GEN_10"} : !hw.inout<i14>
    sv.assign %86, %85 : i14
    %87 = sv.read_inout %34 : !hw.inout<i9>
    %88 = comb.extract %87 from 0 : (i9) -> i1
    %89 = sv.read_inout %86 : !hw.inout<i14>
    %90 = comb.extract %89 from 0 : (i14) -> i13
    %91 = sv.read_inout %86 : !hw.inout<i14>
    %92 = comb.extract %91 from 1 : (i14) -> i13
    %93 = comb.mux %88, %90, %92 : i13
    %94 = sv.read_inout %34 : !hw.inout<i9>
    %95 = comb.icmp sgt %94, %c10_i9 : i9
    %96 = comb.mux %36, %c0_i13, %93 : i13
    %97 = comb.or %95, %7 : i1
    %98 = sv.read_inout %1 : !hw.inout<i1>
    %99 = comb.or %17, %98 : i1
    %100 = comb.or %97, %99 : i1
    sv.alwaysff(posedge %clk) {
      sv.passign %1, %100 : i1
    }(syncreset : posedge %reset) {
      sv.passign %1, %false : i1
    }
    %101 = comb.concat %false, %96 : i1, i13
    %102 = sv.read_inout %23 : !hw.inout<i1>
    %103 = comb.concat %c0_i13, %102 : i13, i1
    %104 = sv.read_inout %0 : !hw.inout<i14>
    %105 = comb.extract %104 from 0 : (i14) -> i13
    %106 = comb.concat %false, %105 : i1, i13
    %107 = comb.add %101, %103 : i14
    %108 = comb.add %106, %107 : i14
    sv.alwaysff(posedge %clk) {
      sv.passign %0, %108 : i14
    }(syncreset : posedge %reset) {
      sv.passign %0, %c0_i14 : i14
    }
    %109 = comb.icmp eq %105, %c0_i13 : i13
    %110 = sv.wire {hw.verilogName = "_GEN_11"} : !hw.inout<i1>
    sv.assign %110, %109 : i1
    %111 = sv.read_inout %0 : !hw.inout<i14>
    %112 = comb.extract %111 from 12 : (i14) -> i1
    %113 = comb.xor %105, %c-1_i13 : i13
    %114 = comb.add %113, %c1_i13 : i13
    %115 = comb.mux %112, %114, %105 : i13
    %116 = sv.wire {hw.verilogName = "_GEN_12"} : !hw.inout<i13>
    sv.assign %116, %115 : i13
    %117 = sv.read_inout %116 : !hw.inout<i13>
    %118 = comb.extract %117 from 5 : (i13) -> i8
    %119 = comb.icmp eq %118, %c0_i8 : i8
    %120 = sv.wire {hw.verilogName = "_GEN_13"} : !hw.inout<i1>
    sv.assign %120, %119 : i1
    %121 = sv.read_inout %116 : !hw.inout<i13>
    %122 = comb.extract %121 from 0 : (i13) -> i5
    %123 = comb.concat %122, %c0_i2 : i5, i2
    %124 = sv.read_inout %116 : !hw.inout<i13>
    %125 = comb.extract %124 from 6 : (i13) -> i7
    %126 = sv.read_inout %120 : !hw.inout<i1>
    %127 = comb.mux %126, %123, %125 : i7
    %128 = sv.wire {hw.verilogName = "_GEN_14"} : !hw.inout<i7>
    sv.assign %128, %127 : i7
    %129 = sv.read_inout %128 : !hw.inout<i7>
    %130 = comb.extract %129 from 3 : (i7) -> i4
    %131 = comb.icmp eq %130, %c0_i4 : i4
    %132 = sv.wire {hw.verilogName = "_GEN_15"} : !hw.inout<i1>
    sv.assign %132, %131 : i1
    %133 = sv.read_inout %128 : !hw.inout<i7>
    %134 = comb.extract %133 from 0 : (i7) -> i3
    %135 = sv.read_inout %128 : !hw.inout<i7>
    %136 = comb.extract %135 from 4 : (i7) -> i3
    %137 = sv.read_inout %132 : !hw.inout<i1>
    %138 = comb.mux %137, %134, %136 : i3
    %139 = sv.wire {hw.verilogName = "_GEN_16"} : !hw.inout<i3>
    sv.assign %139, %138 : i3
    %140 = sv.read_inout %139 : !hw.inout<i3>
    %141 = comb.extract %140 from 1 : (i3) -> i2
    %142 = comb.icmp eq %141, %c0_i2 : i2
    %143 = sv.wire {hw.verilogName = "_GEN_17"} : !hw.inout<i1>
    sv.assign %143, %142 : i1
    %144 = sv.read_inout %139 : !hw.inout<i3>
    %145 = comb.extract %144 from 0 : (i3) -> i1
    %146 = sv.read_inout %139 : !hw.inout<i3>
    %147 = comb.extract %146 from 2 : (i3) -> i1
    %148 = sv.read_inout %143 : !hw.inout<i1>
    %149 = comb.mux %148, %145, %147 : i1
    %150 = comb.xor %149, %true : i1
    %151 = sv.wire {hw.verilogName = "_GEN_18"} : !hw.inout<i1>
    sv.assign %151, %150 : i1
    %152 = sv.read_inout %116 : !hw.inout<i13>
    %153 = comb.extract %152 from 0 : (i13) -> i4
    %154 = comb.concat %153, %c0_i8 : i4, i8
    %155 = sv.read_inout %116 : !hw.inout<i13>
    %156 = comb.extract %155 from 0 : (i13) -> i12
    %157 = sv.read_inout %120 : !hw.inout<i1>
    %158 = comb.mux %157, %154, %156 : i12
    %159 = sv.wire {hw.verilogName = "_GEN_19"} : !hw.inout<i12>
    sv.assign %159, %158 : i12
    %160 = sv.read_inout %159 : !hw.inout<i12>
    %161 = comb.extract %160 from 0 : (i12) -> i8
    %162 = comb.concat %161, %c0_i4 : i8, i4
    %163 = sv.read_inout %132 : !hw.inout<i1>
    %164 = sv.read_inout %159 : !hw.inout<i12>
    %165 = comb.mux %163, %162, %164 : i12
    %166 = sv.wire {hw.verilogName = "_GEN_20"} : !hw.inout<i12>
    sv.assign %166, %165 : i12
    %167 = sv.read_inout %166 : !hw.inout<i12>
    %168 = comb.extract %167 from 0 : (i12) -> i10
    %169 = comb.concat %168, %c0_i2 : i10, i2
    %170 = sv.read_inout %143 : !hw.inout<i1>
    %171 = sv.read_inout %166 : !hw.inout<i12>
    %172 = comb.mux %170, %169, %171 : i12
    %173 = sv.wire {hw.verilogName = "_GEN_21"} : !hw.inout<i12>
    sv.assign %173, %172 : i12
    %174 = sv.read_inout %173 : !hw.inout<i12>
    %175 = comb.extract %174 from 0 : (i12) -> i11
    %176 = comb.concat %175, %false : i11, i1
    %177 = sv.read_inout %151 : !hw.inout<i1>
    %178 = sv.read_inout %173 : !hw.inout<i12>
    %179 = comb.mux %177, %176, %178 : i12
    %180 = sv.read_inout %120 : !hw.inout<i1>
    %181 = sv.read_inout %132 : !hw.inout<i1>
    %182 = sv.read_inout %143 : !hw.inout<i1>
    %183 = sv.read_inout %151 : !hw.inout<i1>
    %184 = comb.concat %c0_i6, %180, %181, %182, %183 : i6, i1, i1, i1, i1
    %185 = comb.sub %c6_i10, %184 : i10
    %186 = comb.add %185, %c127_i10 : i10
    %187 = sv.wire {hw.verilogName = "_GEN_22"} : !hw.inout<i10>
    sv.assign %187, %186 : i10
    %188 = comb.concat %179, %c0_i11 : i12, i11
    %189 = sv.read_inout %187 : !hw.inout<i10>
    %190 = comb.icmp slt %189, %c1_i10 : i10
    %191 = sv.wire {hw.verilogName = "_GEN_23"} : !hw.inout<i1>
    sv.assign %191, %190 : i1
    %192 = sv.read_inout %187 : !hw.inout<i10>
    %193 = comb.icmp sgt %192, %c254_i10 : i10
    %194 = sv.wire {hw.verilogName = "_GEN_24"} : !hw.inout<i1>
    sv.assign %194, %193 : i1
    %195 = sv.read_inout %187 : !hw.inout<i10>
    %196 = comb.extract %195 from 0 : (i10) -> i8
    %197 = sv.read_inout %110 : !hw.inout<i1>
    %198 = sv.read_inout %191 : !hw.inout<i1>
    %199 = comb.or %198, %197 : i1
    %200 = comb.mux %199, %c0_i8, %196 : i8
    %201 = sv.read_inout %194 : !hw.inout<i1>
    %202 = comb.mux %201, %c-1_i8, %200 : i8
    %203 = sv.read_inout %110 : !hw.inout<i1>
    %204 = sv.read_inout %191 : !hw.inout<i1>
    %205 = sv.read_inout %194 : !hw.inout<i1>
    %206 = comb.or %203, %205 : i1
    %207 = comb.or %204, %206 : i1
    %208 = comb.mux %207, %c0_i23, %188 : i23
    %209 = comb.concat %112, %202, %208 : i1, i8, i23
    %210 = sv.read_inout %1 : !hw.inout<i1>
    %211 = comb.mux %210, %c2143289344_i32, %209 : i32
    hw.output %211 : i32
  }
}

