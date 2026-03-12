module {
  hw.module @fpmult_loop_muladd_s3fdp(in %clk : i1 {hw.name = "clk"}, in %reset : i1 {hw.name = "reset"}, in %a : !hw.array<4xi32> {hw.name = "a"}, in %b : !hw.array<4xi32> {hw.name = "b"}, in %c : !hw.array<2xi32> {hw.name = "c"}, in %clk_0 : i1, out r : i32 {hw.name = "r"}) {
    %true = hw.constant true
    %c1_i32 = hw.constant 1 : i32
    %c3_i32 = hw.constant 3 : i32
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %0 = hw.bitcast %b : (!hw.array<4xi32>) -> i128
    %1 = hw.bitcast %a : (!hw.array<4xi32>) -> i128
    %c_mem = sv.reg : !hw.inout<uarray<2xi32>> 
    sv.alwaysff(posedge %clk_0) {
      sv.if %4 {
        %33 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi32>>, i1
        sv.passign %33, %s3fdp_accum.r : i32
      }
    }(syncreset : posedge %reset) {
    }
    %2 = sv.reg : !hw.inout<i32> 
    %3 = sv.read_inout %2 : !hw.inout<i32>
    sv.alwaysff(posedge %clk_0) {
      sv.passign %2, %30 : i32
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
    %7 = comb.icmp eq %6, %c3_i32 : i32
    %8 = comb.add %6, %c1_i32 : i32
    %9 = comb.mux %7, %c0_i32, %8 : i32
    %10 = comb.mux %4, %9, %6 : i32
    %11 = comb.and %4, %7 : i1
    %12 = comb.extract %1 from 0 : (i128) -> i32
    %13 = comb.extract %1 from 32 : (i128) -> i32
    %14 = comb.extract %1 from 64 : (i128) -> i32
    %15 = comb.extract %1 from 96 : (i128) -> i32
    %16 = comb.extract %6 from 0 : (i32) -> i1
    %17 = comb.extract %6 from 1 : (i32) -> i1
    %18 = comb.mux %16, %15, %14 : i32
    %19 = comb.mux %16, %13, %12 : i32
    %20 = comb.mux %17, %18, %19 : i32
    %21 = comb.extract %0 from 0 : (i128) -> i32
    %22 = comb.extract %0 from 32 : (i128) -> i32
    %23 = comb.extract %0 from 64 : (i128) -> i32
    %24 = comb.extract %0 from 96 : (i128) -> i32
    %25 = comb.mux %16, %24, %23 : i32
    %26 = comb.mux %16, %22, %21 : i32
    %27 = comb.mux %17, %25, %26 : i32
    %cg_en_latch = sv.reg : !hw.inout<i1> 
    sv.always  {
      %33 = comb.xor %clk, %true : i1
      sv.if %33 {
        sv.passign %cg_en_latch, %4 : i1
      }
    }
    %28 = sv.read_inout %cg_en_latch : !hw.inout<i1>
    %29 = comb.and %clk, %28 : i1
    %s3fdp_accum.r = hw.instance "s3fdp_accum" @s3fdp_accum_core_wE8_wF23_cs16(clk: %29: i1, reset: %reset: i1, x: %20: i32, y: %27: i32) -> (r: i32)
    %30 = comb.mux %11, %c0_i32, %3 : i32
    %31 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi32>>, i1
    %32 = sv.read_inout %31 : !hw.inout<i32>
    hw.output %32 : i32
  }
  hw.module @s3fdp_accum_core_wE8_wF23_cs16(in %clk : i1, in %reset : i1, in %x : i32, in %y : i32, out r : i32) {
    %c0_i65 = hw.constant 0 : i65
    %c0_i13 = hw.constant 0 : i13
    %c2143289344_i32 = hw.constant 2143289344 : i32
    %c1_i10 = hw.constant 1 : i10
    %c0_i6 = hw.constant 0 : i6
    %c-247_i9 = hw.constant -247 : i9
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
    %22 = comb.add %19, %18, %c-247_i9 : i9
    %23 = comb.extract %22 from 8 : (i9) -> i1
    %24 = comb.concat %c0_i17, %21 : i17, i48
    %25 = comb.extract %22 from 7 : (i9) -> i1
    %26 = comb.or %25, %23 : i1
    %27 = comb.mux %26, %c0_i65, %24 : i65
    %28 = comb.extract %22 from 6 : (i9) -> i1
    %29 = comb.extract %27 from 0 : (i65) -> i1
    %30 = comb.concat %29, %c0_i64 : i1, i64
    %31 = comb.mux %28, %30, %27 : i65
    %32 = comb.extract %22 from 5 : (i9) -> i1
    %33 = comb.extract %31 from 0 : (i65) -> i33
    %34 = comb.concat %33, %c0_i16 : i33, i16
    %35 = comb.extract %31 from 16 : (i65) -> i49
    %36 = comb.mux %32, %34, %35 : i49
    %37 = comb.extract %22 from 4 : (i9) -> i1
    %38 = comb.extract %36 from 0 : (i49) -> i33
    %39 = comb.extract %36 from 16 : (i49) -> i33
    %40 = comb.mux %37, %38, %39 : i33
    %41 = comb.extract %22 from 3 : (i9) -> i1
    %42 = comb.extract %40 from 0 : (i33) -> i25
    %43 = comb.extract %40 from 8 : (i33) -> i25
    %44 = comb.mux %41, %42, %43 : i25
    %45 = comb.extract %22 from 2 : (i9) -> i1
    %46 = comb.extract %44 from 0 : (i25) -> i21
    %47 = comb.extract %44 from 4 : (i25) -> i21
    %48 = comb.mux %45, %46, %47 : i21
    %49 = comb.extract %22 from 1 : (i9) -> i1
    %50 = comb.extract %48 from 0 : (i21) -> i19
    %51 = comb.extract %48 from 2 : (i21) -> i19
    %52 = comb.mux %49, %50, %51 : i19
    %53 = comb.extract %22 from 0 : (i9) -> i1
    %54 = comb.extract %52 from 0 : (i19) -> i18
    %55 = comb.extract %52 from 1 : (i19) -> i18
    %56 = comb.mux %53, %54, %55 : i18
    %57 = comb.icmp sgt %22, %c12_i9 : i9
    %58 = comb.mux %23, %c0_i18, %56 : i18
    %59 = comb.or %57, %4, %11, %61 : i1
    %60 = sv.reg : !hw.inout<i1> 
    %61 = sv.read_inout %60 : !hw.inout<i1>
    sv.alwaysff(posedge %clk) {
      sv.passign %60, %59 : i1
    }(syncreset : posedge %reset) {
      sv.passign %60, %false : i1
    }
    %62 = comb.extract %58 from 0 : (i18) -> i16
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
    %71 = comb.extract %58 from 16 : (i18) -> i2
    %72 = comb.concat %false, %71 : i1, i2
    %73 = comb.concat %c0_i2, %70 : i2, i1
    %74 = comb.extract %78 from 0 : (i3) -> i2
    %75 = comb.concat %false, %74 : i1, i2
    %76 = comb.add %75, %72, %73 : i3
    %77 = sv.reg : !hw.inout<i3> 
    %78 = sv.read_inout %77 : !hw.inout<i3>
    sv.alwaysff(posedge %clk) {
      sv.passign %77, %76 : i3
    }(syncreset : posedge %reset) {
      sv.passign %77, %c0_i3 : i3
    }
    %79 = comb.concat %74, %65 : i2, i16
    %80 = comb.concat %c0_i8, %70, %c0_i9 : i8, i1, i9
    %81 = comb.add %79, %80 : i18
    %82 = comb.icmp eq %81, %c0_i18 : i18
    %83 = comb.extract %81 from 17 : (i18) -> i1
    %84 = comb.xor %81, %c-1_i18 : i18
    %85 = comb.add %84, %c1_i18 : i18
    %86 = comb.mux %83, %85, %81 : i18
    %87 = comb.extract %86 from 2 : (i18) -> i16
    %88 = comb.icmp eq %87, %c0_i16 : i16
    %89 = comb.extract %86 from 0 : (i18) -> i2
    %90 = comb.concat %89, %c0_i13 : i2, i13
    %91 = comb.extract %86 from 3 : (i18) -> i15
    %92 = comb.mux %88, %90, %91 : i15
    %93 = comb.extract %92 from 7 : (i15) -> i8
    %94 = comb.icmp eq %93, %c0_i8 : i8
    %95 = comb.extract %92 from 0 : (i15) -> i7
    %96 = comb.extract %92 from 8 : (i15) -> i7
    %97 = comb.mux %94, %95, %96 : i7
    %98 = comb.extract %97 from 3 : (i7) -> i4
    %99 = comb.icmp eq %98, %c0_i4 : i4
    %100 = comb.extract %97 from 0 : (i7) -> i3
    %101 = comb.extract %97 from 4 : (i7) -> i3
    %102 = comb.mux %99, %100, %101 : i3
    %103 = comb.extract %102 from 1 : (i3) -> i2
    %104 = comb.icmp eq %103, %c0_i2 : i2
    %105 = comb.extract %102 from 0 : (i3) -> i1
    %106 = comb.extract %102 from 2 : (i3) -> i1
    %107 = comb.mux %104, %105, %106 : i1
    %108 = comb.xor %107, %true : i1
    %109 = comb.extract %86 from 0 : (i18) -> i1
    %110 = comb.concat %109, %c0_i16 : i1, i16
    %111 = comb.extract %86 from 0 : (i18) -> i17
    %112 = comb.mux %88, %110, %111 : i17
    %113 = comb.extract %112 from 0 : (i17) -> i9
    %114 = comb.concat %113, %c0_i8 : i9, i8
    %115 = comb.mux %94, %114, %112 : i17
    %116 = comb.extract %115 from 0 : (i17) -> i13
    %117 = comb.concat %116, %c0_i4 : i13, i4
    %118 = comb.mux %99, %117, %115 : i17
    %119 = comb.extract %118 from 0 : (i17) -> i15
    %120 = comb.concat %119, %c0_i2 : i15, i2
    %121 = comb.mux %104, %120, %118 : i17
    %122 = comb.extract %121 from 0 : (i17) -> i16
    %123 = comb.concat %122, %false : i16, i1
    %124 = comb.mux %108, %123, %121 : i17
    %125 = comb.concat %c0_i5, %88, %94, %99, %104, %108 : i5, i1, i1, i1, i1, i1
    %126 = comb.sub %c11_i10, %125 : i10
    %127 = comb.add %126, %c127_i10 : i10
    %128 = comb.concat %124, %c0_i6 : i17, i6
    %129 = comb.icmp slt %127, %c1_i10 : i10
    %130 = comb.icmp sgt %127, %c254_i10 : i10
    %131 = comb.extract %127 from 0 : (i10) -> i8
    %132 = comb.or %129, %82 : i1
    %133 = comb.mux %132, %c0_i8, %131 : i8
    %134 = comb.mux %130, %c-1_i8, %133 : i8
    %135 = comb.or %129, %82, %130 : i1
    %136 = comb.mux %135, %c0_i23, %128 : i23
    %137 = comb.concat %83, %134, %136 : i1, i8, i23
    %138 = comb.mux %61, %c2143289344_i32, %137 : i32
    hw.output %138 : i32
  }
}

