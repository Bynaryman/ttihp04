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
    %c0_i15 = hw.constant 0 : i15
    %c0_i63 = hw.constant 0 : i63
    %c2143289344_i32 = hw.constant 2143289344 : i32
    %c1_i10 = hw.constant 1 : i10
    %c-247_i9 = hw.constant -247 : i9
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
    %24 = comb.concat %c0_i15, %21 : i15, i48
    %25 = comb.extract %22 from 7 : (i9) -> i1
    %26 = comb.extract %22 from 6 : (i9) -> i1
    %27 = comb.or %26, %25, %23 : i1
    %28 = comb.mux %27, %c0_i63, %24 : i63
    %29 = comb.extract %22 from 5 : (i9) -> i1
    %30 = comb.extract %28 from 0 : (i63) -> i31
    %31 = comb.concat %30, %c0_i16 : i31, i16
    %32 = comb.extract %28 from 16 : (i63) -> i47
    %33 = comb.mux %29, %31, %32 : i47
    %34 = comb.extract %22 from 4 : (i9) -> i1
    %35 = comb.extract %33 from 0 : (i47) -> i31
    %36 = comb.extract %33 from 16 : (i47) -> i31
    %37 = comb.mux %34, %35, %36 : i31
    %38 = comb.extract %22 from 3 : (i9) -> i1
    %39 = comb.extract %37 from 0 : (i31) -> i23
    %40 = comb.extract %37 from 8 : (i31) -> i23
    %41 = comb.mux %38, %39, %40 : i23
    %42 = comb.extract %22 from 2 : (i9) -> i1
    %43 = comb.extract %41 from 0 : (i23) -> i19
    %44 = comb.extract %41 from 4 : (i23) -> i19
    %45 = comb.mux %42, %43, %44 : i19
    %46 = comb.extract %22 from 1 : (i9) -> i1
    %47 = comb.extract %45 from 0 : (i19) -> i17
    %48 = comb.extract %45 from 2 : (i19) -> i17
    %49 = comb.mux %46, %47, %48 : i17
    %50 = comb.extract %22 from 0 : (i9) -> i1
    %51 = comb.extract %49 from 0 : (i17) -> i16
    %52 = comb.extract %49 from 1 : (i17) -> i16
    %53 = comb.mux %50, %51, %52 : i16
    %54 = comb.icmp sgt %22, %c11_i9 : i9
    %55 = comb.mux %23, %c0_i16, %53 : i16
    %56 = comb.or %54, %4, %11, %58 : i1
    %57 = sv.reg : !hw.inout<i1> 
    %58 = sv.read_inout %57 : !hw.inout<i1>
    sv.alwaysff(posedge %clk) {
      sv.passign %57, %56 : i1
    }(syncreset : posedge %reset) {
      sv.passign %57, %false : i1
    }
    %59 = comb.concat %false, %55 : i1, i16
    %60 = comb.concat %c0_i16, %14 : i16, i1
    %61 = comb.extract %65 from 0 : (i17) -> i16
    %62 = comb.concat %false, %61 : i1, i16
    %63 = comb.add %62, %59, %60 : i17
    %64 = sv.reg : !hw.inout<i17> 
    %65 = sv.read_inout %64 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %64, %63 : i17
    }(syncreset : posedge %reset) {
      sv.passign %64, %c0_i17 : i17
    }
    %66 = comb.icmp eq %61, %c0_i16 : i16
    %67 = comb.extract %65 from 15 : (i17) -> i1
    %68 = comb.xor %61, %c-1_i16 : i16
    %69 = comb.add %68, %c1_i16 : i16
    %70 = comb.mux %67, %69, %61 : i16
    %71 = comb.extract %70 from 8 : (i16) -> i8
    %72 = comb.icmp eq %71, %c0_i8 : i8
    %73 = comb.extract %70 from 1 : (i16) -> i7
    %74 = comb.extract %70 from 9 : (i16) -> i7
    %75 = comb.mux %72, %73, %74 : i7
    %76 = comb.extract %75 from 3 : (i7) -> i4
    %77 = comb.icmp eq %76, %c0_i4 : i4
    %78 = comb.extract %75 from 0 : (i7) -> i3
    %79 = comb.extract %75 from 4 : (i7) -> i3
    %80 = comb.mux %77, %78, %79 : i3
    %81 = comb.extract %80 from 1 : (i3) -> i2
    %82 = comb.icmp eq %81, %c0_i2 : i2
    %83 = comb.extract %80 from 0 : (i3) -> i1
    %84 = comb.extract %80 from 2 : (i3) -> i1
    %85 = comb.mux %82, %83, %84 : i1
    %86 = comb.xor %85, %true : i1
    %87 = comb.extract %70 from 0 : (i16) -> i7
    %88 = comb.concat %87, %c0_i8 : i7, i8
    %89 = comb.extract %70 from 0 : (i16) -> i15
    %90 = comb.mux %72, %88, %89 : i15
    %91 = comb.extract %90 from 0 : (i15) -> i11
    %92 = comb.concat %91, %c0_i4 : i11, i4
    %93 = comb.mux %77, %92, %90 : i15
    %94 = comb.extract %93 from 0 : (i15) -> i13
    %95 = comb.concat %94, %c0_i2 : i13, i2
    %96 = comb.mux %82, %95, %93 : i15
    %97 = comb.extract %96 from 0 : (i15) -> i14
    %98 = comb.concat %97, %false : i14, i1
    %99 = comb.mux %86, %98, %96 : i15
    %100 = comb.concat %c0_i6, %72, %77, %82, %86 : i6, i1, i1, i1, i1
    %101 = comb.sub %c9_i10, %100 : i10
    %102 = comb.add %101, %c127_i10 : i10
    %103 = comb.concat %99, %c0_i8 : i15, i8
    %104 = comb.icmp slt %102, %c1_i10 : i10
    %105 = comb.icmp sgt %102, %c254_i10 : i10
    %106 = comb.extract %102 from 0 : (i10) -> i8
    %107 = comb.or %104, %66 : i1
    %108 = comb.mux %107, %c0_i8, %106 : i8
    %109 = comb.mux %105, %c-1_i8, %108 : i8
    %110 = comb.or %104, %66, %105 : i1
    %111 = comb.mux %110, %c0_i23, %103 : i23
    %112 = comb.concat %67, %109, %111 : i1, i8, i23
    %113 = comb.mux %58, %c2143289344_i32, %112 : i32
    hw.output %113 : i32
  }
}

