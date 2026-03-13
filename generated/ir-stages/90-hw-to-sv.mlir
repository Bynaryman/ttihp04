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
    %c0_i12 = hw.constant 0 : i12
    %c0_i60 = hw.constant 0 : i60
    %c0_i16 = hw.constant 0 : i16
    %c2143289344_i32 = hw.constant 2143289344 : i32
    %c1_i10 = hw.constant 1 : i10
    %c0_i11 = hw.constant 0 : i11
    %c-247_i9 = hw.constant -247 : i9
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
    %24 = comb.concat %c0_i12, %21 : i12, i48
    %25 = comb.extract %22 from 7 : (i9) -> i1
    %26 = comb.extract %22 from 6 : (i9) -> i1
    %27 = comb.or %26, %25, %23 : i1
    %28 = comb.mux %27, %c0_i60, %24 : i60
    %29 = comb.extract %22 from 5 : (i9) -> i1
    %30 = comb.extract %28 from 0 : (i60) -> i28
    %31 = comb.concat %30, %c0_i16 : i28, i16
    %32 = comb.extract %28 from 16 : (i60) -> i44
    %33 = comb.mux %29, %31, %32 : i44
    %34 = comb.extract %22 from 4 : (i9) -> i1
    %35 = comb.extract %33 from 0 : (i44) -> i28
    %36 = comb.extract %33 from 16 : (i44) -> i28
    %37 = comb.mux %34, %35, %36 : i28
    %38 = comb.extract %22 from 3 : (i9) -> i1
    %39 = comb.extract %37 from 0 : (i28) -> i20
    %40 = comb.extract %37 from 8 : (i28) -> i20
    %41 = comb.mux %38, %39, %40 : i20
    %42 = comb.extract %22 from 2 : (i9) -> i1
    %43 = comb.extract %41 from 0 : (i20) -> i16
    %44 = comb.extract %41 from 4 : (i20) -> i16
    %45 = comb.mux %42, %43, %44 : i16
    %46 = comb.extract %22 from 1 : (i9) -> i1
    %47 = comb.extract %45 from 0 : (i16) -> i14
    %48 = comb.extract %45 from 2 : (i16) -> i14
    %49 = comb.mux %46, %47, %48 : i14
    %50 = comb.extract %22 from 0 : (i9) -> i1
    %51 = comb.extract %49 from 0 : (i14) -> i13
    %52 = comb.extract %49 from 1 : (i14) -> i13
    %53 = comb.mux %50, %51, %52 : i13
    %54 = comb.icmp sgt %22, %c10_i9 : i9
    %55 = comb.mux %23, %c0_i13, %53 : i13
    %56 = comb.or %54, %4, %11, %58 : i1
    %57 = sv.reg : !hw.inout<i1> 
    %58 = sv.read_inout %57 : !hw.inout<i1>
    sv.alwaysff(posedge %clk) {
      sv.passign %57, %56 : i1
    }(syncreset : posedge %reset) {
      sv.passign %57, %false : i1
    }
    %59 = comb.concat %false, %55 : i1, i13
    %60 = comb.concat %c0_i13, %14 : i13, i1
    %61 = comb.extract %65 from 0 : (i14) -> i13
    %62 = comb.concat %false, %61 : i1, i13
    %63 = comb.add %62, %59, %60 : i14
    %64 = sv.reg : !hw.inout<i14> 
    %65 = sv.read_inout %64 : !hw.inout<i14>
    sv.alwaysff(posedge %clk) {
      sv.passign %64, %63 : i14
    }(syncreset : posedge %reset) {
      sv.passign %64, %c0_i14 : i14
    }
    %66 = comb.icmp eq %61, %c0_i13 : i13
    %67 = comb.extract %65 from 12 : (i14) -> i1
    %68 = comb.xor %61, %c-1_i13 : i13
    %69 = comb.add %68, %c1_i13 : i13
    %70 = comb.mux %67, %69, %61 : i13
    %71 = comb.extract %70 from 5 : (i13) -> i8
    %72 = comb.icmp eq %71, %c0_i8 : i8
    %73 = comb.extract %70 from 0 : (i13) -> i5
    %74 = comb.concat %73, %c0_i2 : i5, i2
    %75 = comb.extract %70 from 6 : (i13) -> i7
    %76 = comb.mux %72, %74, %75 : i7
    %77 = comb.extract %76 from 3 : (i7) -> i4
    %78 = comb.icmp eq %77, %c0_i4 : i4
    %79 = comb.extract %76 from 0 : (i7) -> i3
    %80 = comb.extract %76 from 4 : (i7) -> i3
    %81 = comb.mux %78, %79, %80 : i3
    %82 = comb.extract %81 from 1 : (i3) -> i2
    %83 = comb.icmp eq %82, %c0_i2 : i2
    %84 = comb.extract %81 from 0 : (i3) -> i1
    %85 = comb.extract %81 from 2 : (i3) -> i1
    %86 = comb.mux %83, %84, %85 : i1
    %87 = comb.xor %86, %true : i1
    %88 = comb.extract %70 from 0 : (i13) -> i4
    %89 = comb.concat %88, %c0_i8 : i4, i8
    %90 = comb.extract %70 from 0 : (i13) -> i12
    %91 = comb.mux %72, %89, %90 : i12
    %92 = comb.extract %91 from 0 : (i12) -> i8
    %93 = comb.concat %92, %c0_i4 : i8, i4
    %94 = comb.mux %78, %93, %91 : i12
    %95 = comb.extract %94 from 0 : (i12) -> i10
    %96 = comb.concat %95, %c0_i2 : i10, i2
    %97 = comb.mux %83, %96, %94 : i12
    %98 = comb.extract %97 from 0 : (i12) -> i11
    %99 = comb.concat %98, %false : i11, i1
    %100 = comb.mux %87, %99, %97 : i12
    %101 = comb.concat %c0_i6, %72, %78, %83, %87 : i6, i1, i1, i1, i1
    %102 = comb.sub %c6_i10, %101 : i10
    %103 = comb.add %102, %c127_i10 : i10
    %104 = comb.concat %100, %c0_i11 : i12, i11
    %105 = comb.icmp slt %103, %c1_i10 : i10
    %106 = comb.icmp sgt %103, %c254_i10 : i10
    %107 = comb.extract %103 from 0 : (i10) -> i8
    %108 = comb.or %105, %66 : i1
    %109 = comb.mux %108, %c0_i8, %107 : i8
    %110 = comb.mux %106, %c-1_i8, %109 : i8
    %111 = comb.or %105, %66, %106 : i1
    %112 = comb.mux %111, %c0_i23, %104 : i23
    %113 = comb.concat %67, %110, %112 : i1, i8, i23
    %114 = comb.mux %58, %c2143289344_i32, %113 : i32
    hw.output %114 : i32
  }
}

