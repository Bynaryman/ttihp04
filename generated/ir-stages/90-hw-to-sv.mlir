module {
  hw.module @fpmult_loop_muladd_s3fdp(in %clk : i1 {hw.name = "clk"}, in %reset : i1 {hw.name = "reset"}, in %a : !hw.array<2xi32> {hw.name = "a"}, in %b : !hw.array<2xi32> {hw.name = "b"}, in %c : !hw.array<2xi32> {hw.name = "c"}, in %clk_0 : i1, out r : i32 {hw.name = "r"}) {
    %true = hw.constant true
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %0 = hw.bitcast %b : (!hw.array<2xi32>) -> i64
    %1 = hw.bitcast %a : (!hw.array<2xi32>) -> i64
    %c_mem = sv.reg : !hw.inout<uarray<2xi32>> 
    sv.alwaysff(posedge %clk_0) {
      sv.if %4 {
        %24 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi32>>, i1
        sv.passign %24, %s3fdp_accum.r : i32
      }
    }(syncreset : posedge %reset) {
    }
    %2 = sv.reg : !hw.inout<i32> 
    %3 = sv.read_inout %2 : !hw.inout<i32>
    sv.alwaysff(posedge %clk_0) {
      sv.passign %2, %21 : i32
    }(syncreset : posedge %reset) {
      sv.passign %2, %c0_i32 : i32
    }
    %4 = comb.icmp eq %3, %c0_i32 : i32
    %5 = sv.reg : !hw.inout<i32> 
    %6 = sv.read_inout %5 : !hw.inout<i32>
    sv.alwaysff(posedge %clk_0) {
      sv.passign %5, %10 : i32
    }(syncreset : posedge %reset) {
      sv.passign %5, %c0_i32 : i32
    }
    %7 = comb.icmp eq %6, %c1_i32 : i32
    %8 = comb.add %6, %c1_i32 : i32
    %9 = comb.mux %7, %c0_i32, %8 : i32
    %10 = comb.mux %4, %9, %6 : i32
    %11 = comb.and %4, %7 : i1
    %12 = comb.extract %6 from 0 : (i32) -> i1
    %13 = comb.extract %1 from 0 : (i64) -> i32
    %14 = comb.extract %1 from 32 : (i64) -> i32
    %15 = comb.mux %12, %14, %13 : i32
    %16 = comb.extract %0 from 0 : (i64) -> i32
    %17 = comb.extract %0 from 32 : (i64) -> i32
    %18 = comb.mux %12, %17, %16 : i32
    %cg_en_latch = sv.reg : !hw.inout<i1> 
    sv.always  {
      %24 = comb.xor %clk, %true : i1
      sv.if %24 {
        sv.passign %cg_en_latch, %4 : i1
      }
    }
    %19 = sv.read_inout %cg_en_latch : !hw.inout<i1>
    %20 = comb.and %clk, %19 : i1
    %s3fdp_accum.r = hw.instance "s3fdp_accum" @s3fdp_accum_core_wE8_wF23_cs16(clk: %20: i1, reset: %reset: i1, x: %15: i32, y: %18: i32) -> (r: i32)
    %21 = comb.mux %11, %c0_i32, %3 : i32
    %22 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi32>>, i1
    %23 = sv.read_inout %22 : !hw.inout<i32>
    hw.output %23 : i32
  }
  hw.module @s3fdp_accum_core_wE8_wF23_cs16(in %clk : i1, in %reset : i1, in %x : i32, in %y : i32, out r : i32) {
    %c0_i38 = hw.constant 0 : i38
    %c0_i86 = hw.constant 0 : i86
    %c2143289344_i32 = hw.constant 2143289344 : i32
    %c1_i10 = hw.constant 1 : i10
    %c1_i2 = hw.constant 1 : i2
    %c-230_i9 = hw.constant -230 : i9
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
    %0 = comb.extract %x from 31 : (i32) -> i1
    %1 = comb.extract %x from 23 : (i32) -> i8
    %2 = comb.extract %x from 0 : (i32) -> i23
    %3 = comb.icmp eq %1, %c0_i8 : i8
    %4 = comb.icmp eq %1, %c-1_i8 : i8
    %5 = comb.xor %3, %true : i1
    %6 = comb.mux %3, %c1_i8, %1 : i8
    %7 = comb.extract %y from 31 : (i32) -> i1
    %8 = comb.extract %y from 23 : (i32) -> i8
    %9 = comb.extract %y from 0 : (i32) -> i23
    %10 = comb.icmp eq %8, %c0_i8 : i8
    %11 = comb.icmp eq %8, %c-1_i8 : i8
    %12 = comb.xor %10, %true : i1
    %13 = comb.mux %10, %c1_i8, %8 : i8
    %14 = comb.xor %0, %7 : i1
    %15 = comb.concat %c0_i24, %5, %2 : i24, i1, i23
    %16 = comb.concat %c0_i24, %12, %9 : i24, i1, i23
    %17 = comb.mul %15, %16 : i48
    %18 = comb.concat %false, %13 : i1, i8
    %19 = comb.concat %false, %6 : i1, i8
    %20 = comb.replicate %14 : (i1) -> i48
    %21 = comb.xor %20, %17 : i48
    %22 = comb.add %19, %18, %c-230_i9 : i9
    %23 = comb.extract %22 from 8 : (i9) -> i1
    %24 = comb.concat %c0_i38, %21 : i38, i48
    %25 = comb.extract %22 from 7 : (i9) -> i1
    %26 = comb.or %25, %23 : i1
    %27 = comb.mux %26, %c0_i86, %24 : i86
    %28 = comb.extract %22 from 6 : (i9) -> i1
    %29 = comb.extract %27 from 0 : (i86) -> i22
    %30 = comb.concat %29, %c0_i64 : i22, i64
    %31 = comb.mux %28, %30, %27 : i86
    %32 = comb.extract %22 from 5 : (i9) -> i1
    %33 = comb.extract %31 from 0 : (i86) -> i54
    %34 = comb.concat %33, %c0_i16 : i54, i16
    %35 = comb.extract %31 from 16 : (i86) -> i70
    %36 = comb.mux %32, %34, %35 : i70
    %37 = comb.extract %22 from 4 : (i9) -> i1
    %38 = comb.extract %36 from 0 : (i70) -> i54
    %39 = comb.extract %36 from 16 : (i70) -> i54
    %40 = comb.mux %37, %38, %39 : i54
    %41 = comb.extract %22 from 3 : (i9) -> i1
    %42 = comb.extract %40 from 0 : (i54) -> i46
    %43 = comb.extract %40 from 8 : (i54) -> i46
    %44 = comb.mux %41, %42, %43 : i46
    %45 = comb.extract %22 from 2 : (i9) -> i1
    %46 = comb.extract %44 from 0 : (i46) -> i42
    %47 = comb.extract %44 from 4 : (i46) -> i42
    %48 = comb.mux %45, %46, %47 : i42
    %49 = comb.extract %22 from 1 : (i9) -> i1
    %50 = comb.extract %48 from 0 : (i42) -> i40
    %51 = comb.extract %48 from 2 : (i42) -> i40
    %52 = comb.mux %49, %50, %51 : i40
    %53 = comb.extract %22 from 0 : (i9) -> i1
    %54 = comb.extract %52 from 0 : (i40) -> i39
    %55 = comb.extract %52 from 1 : (i40) -> i39
    %56 = comb.mux %53, %54, %55 : i39
    %57 = comb.icmp sgt %22, %c33_i9 : i9
    %58 = comb.mux %23, %c0_i39, %56 : i39
    %59 = comb.or %57, %4, %11, %61 : i1
    %60 = sv.reg : !hw.inout<i1> 
    %61 = sv.read_inout %60 : !hw.inout<i1>
    sv.alwaysff(posedge %clk) {
      sv.passign %60, %59 : i1
    }(syncreset : posedge %reset) {
      sv.passign %60, %false : i1
    }
    %62 = comb.extract %58 from 0 : (i39) -> i16
    %63 = comb.concat %false, %62 : i1, i16
    %64 = comb.concat %c0_i16, %14 : i16, i1
    %65 = comb.extract %69 from 0 : (i17) -> i16
    %66 = comb.concat %false, %65 : i1, i16
    %67 = comb.add %66, %63, %64 : i17
    %68 = sv.reg : !hw.inout<i17> 
    %69 = sv.read_inout %68 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %68, %67 : i17
    }(syncreset : posedge %reset) {
      sv.passign %68, %c0_i17 : i17
    }
    %70 = comb.extract %69 from 16 : (i17) -> i1
    %71 = comb.extract %58 from 16 : (i39) -> i16
    %72 = comb.concat %false, %71 : i1, i16
    %73 = comb.concat %c0_i16, %70 : i16, i1
    %74 = comb.extract %78 from 0 : (i17) -> i16
    %75 = comb.concat %false, %74 : i1, i16
    %76 = comb.add %75, %72, %73 : i17
    %77 = sv.reg : !hw.inout<i17> 
    %78 = sv.read_inout %77 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %77, %76 : i17
    }(syncreset : posedge %reset) {
      sv.passign %77, %c0_i17 : i17
    }
    %79 = comb.extract %78 from 16 : (i17) -> i1
    %80 = comb.extract %58 from 32 : (i39) -> i7
    %81 = comb.concat %false, %80 : i1, i7
    %82 = comb.concat %c0_i7, %79 : i7, i1
    %83 = comb.extract %87 from 0 : (i8) -> i7
    %84 = comb.concat %false, %83 : i1, i7
    %85 = comb.add %84, %81, %82 : i8
    %86 = sv.reg : !hw.inout<i8> 
    %87 = sv.read_inout %86 : !hw.inout<i8>
    sv.alwaysff(posedge %clk) {
      sv.passign %86, %85 : i8
    }(syncreset : posedge %reset) {
      sv.passign %86, %c0_i8 : i8
    }
    %88 = comb.concat %83, %74, %65 : i7, i16, i16
    %89 = comb.concat %c0_i12, %79, %c0_i12, %70, %c0_i13 : i12, i1, i12, i1, i13
    %90 = comb.add %88, %89 : i39
    %91 = comb.icmp eq %90, %c0_i39 : i39
    %92 = comb.extract %90 from 38 : (i39) -> i1
    %93 = comb.xor %90, %c-1_i39 : i39
    %94 = comb.add %93, %c1_i39 : i39
    %95 = comb.mux %92, %94, %90 : i39
    %96 = comb.extract %95 from 7 : (i39) -> i32
    %97 = comb.icmp eq %96, %c0_i32 : i32
    %98 = comb.extract %95 from 0 : (i39) -> i7
    %99 = comb.concat %98, %c0_i24 : i7, i24
    %100 = comb.extract %95 from 8 : (i39) -> i31
    %101 = comb.mux %97, %99, %100 : i31
    %102 = comb.extract %101 from 15 : (i31) -> i16
    %103 = comb.icmp eq %102, %c0_i16 : i16
    %104 = comb.extract %101 from 0 : (i31) -> i15
    %105 = comb.extract %101 from 16 : (i31) -> i15
    %106 = comb.mux %103, %104, %105 : i15
    %107 = comb.extract %106 from 7 : (i15) -> i8
    %108 = comb.icmp eq %107, %c0_i8 : i8
    %109 = comb.extract %106 from 0 : (i15) -> i7
    %110 = comb.extract %106 from 8 : (i15) -> i7
    %111 = comb.mux %108, %109, %110 : i7
    %112 = comb.extract %111 from 3 : (i7) -> i4
    %113 = comb.icmp eq %112, %c0_i4 : i4
    %114 = comb.extract %111 from 0 : (i7) -> i3
    %115 = comb.extract %111 from 4 : (i7) -> i3
    %116 = comb.mux %113, %114, %115 : i3
    %117 = comb.extract %116 from 1 : (i3) -> i2
    %118 = comb.icmp eq %117, %c0_i2 : i2
    %119 = comb.extract %116 from 0 : (i3) -> i1
    %120 = comb.extract %116 from 2 : (i3) -> i1
    %121 = comb.mux %118, %119, %120 : i1
    %122 = comb.xor %121, %true : i1
    %123 = comb.extract %95 from 0 : (i39) -> i6
    %124 = comb.concat %123, %c0_i32 : i6, i32
    %125 = comb.extract %95 from 0 : (i39) -> i38
    %126 = comb.mux %97, %124, %125 : i38
    %127 = comb.extract %126 from 0 : (i38) -> i22
    %128 = comb.concat %127, %c0_i16 : i22, i16
    %129 = comb.mux %103, %128, %126 : i38
    %130 = comb.extract %129 from 0 : (i38) -> i30
    %131 = comb.concat %130, %c0_i8 : i30, i8
    %132 = comb.mux %108, %131, %129 : i38
    %133 = comb.extract %132 from 0 : (i38) -> i34
    %134 = comb.concat %133, %c0_i4 : i34, i4
    %135 = comb.mux %113, %134, %132 : i38
    %136 = comb.extract %135 from 0 : (i38) -> i36
    %137 = comb.concat %136, %c0_i2 : i36, i2
    %138 = comb.mux %118, %137, %135 : i38
    %139 = comb.extract %138 from 0 : (i38) -> i37
    %140 = comb.concat %139, %false : i37, i1
    %141 = comb.mux %122, %140, %138 : i38
    %142 = comb.extract %141 from 0 : (i38) -> i13
    %143 = comb.icmp ne %142, %c0_i13 : i13
    %144 = comb.concat %c0_i4, %97, %103, %108, %113, %118, %122 : i4, i1, i1, i1, i1, i1, i1
    %145 = comb.sub %c15_i10, %144 : i10
    %146 = comb.extract %141 from 15 : (i38) -> i23
    %147 = comb.extract %141 from 14 : (i38) -> i1
    %148 = comb.extract %141 from 13 : (i38) -> i1
    %149 = comb.extract %141 from 15 : (i38) -> i1
    %150 = comb.or %148, %143, %149 : i1
    %151 = comb.and %147, %150 : i1
    %152 = comb.concat %c0_i24, %151 : i24, i1
    %153 = comb.concat %c1_i2, %146 : i2, i23
    %154 = comb.add %153, %152 : i25
    %155 = comb.extract %154 from 24 : (i25) -> i1
    %156 = comb.extract %154 from 1 : (i25) -> i23
    %157 = comb.extract %154 from 0 : (i25) -> i23
    %158 = comb.mux %155, %156, %157 : i23
    %159 = comb.concat %c0_i9, %155 : i9, i1
    %160 = comb.add %145, %159, %c127_i10 : i10
    %161 = comb.icmp slt %160, %c1_i10 : i10
    %162 = comb.icmp sgt %160, %c254_i10 : i10
    %163 = comb.extract %160 from 0 : (i10) -> i8
    %164 = comb.or %161, %91 : i1
    %165 = comb.mux %164, %c0_i8, %163 : i8
    %166 = comb.mux %162, %c-1_i8, %165 : i8
    %167 = comb.or %161, %91, %162 : i1
    %168 = comb.mux %167, %c0_i23, %158 : i23
    %169 = comb.concat %92, %166, %168 : i1, i8, i23
    %170 = comb.mux %61, %c2143289344_i32, %169 : i32
    hw.output %170 : i32
  }
}

