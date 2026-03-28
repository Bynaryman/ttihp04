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
    %22 = comb.add %19, %18, %c45_i9 : i9
    %23 = comb.concat %c0_i511, %21 : i511, i48
    %24 = comb.extract %22 from 8 : (i9) -> i1
    %25 = comb.concat %c0_i255, %21, %c0_i256 : i255, i48, i256
    %26 = comb.mux %24, %25, %23 : i559
    %27 = comb.extract %22 from 7 : (i9) -> i1
    %28 = comb.extract %26 from 0 : (i559) -> i431
    %29 = comb.concat %28, %c0_i128 : i431, i128
    %30 = comb.mux %27, %29, %26 : i559
    %31 = comb.extract %22 from 6 : (i9) -> i1
    %32 = comb.extract %30 from 0 : (i559) -> i495
    %33 = comb.concat %32, %c0_i64 : i495, i64
    %34 = comb.mux %31, %33, %30 : i559
    %35 = comb.extract %22 from 5 : (i9) -> i1
    %36 = comb.extract %34 from 0 : (i559) -> i527
    %37 = comb.concat %36, %c0_i16 : i527, i16
    %38 = comb.extract %34 from 16 : (i559) -> i543
    %39 = comb.mux %35, %37, %38 : i543
    %40 = comb.extract %22 from 4 : (i9) -> i1
    %41 = comb.extract %39 from 0 : (i543) -> i527
    %42 = comb.extract %39 from 16 : (i543) -> i527
    %43 = comb.mux %40, %41, %42 : i527
    %44 = comb.extract %22 from 3 : (i9) -> i1
    %45 = comb.extract %43 from 0 : (i527) -> i519
    %46 = comb.extract %43 from 8 : (i527) -> i519
    %47 = comb.mux %44, %45, %46 : i519
    %48 = comb.extract %22 from 2 : (i9) -> i1
    %49 = comb.extract %47 from 0 : (i519) -> i515
    %50 = comb.extract %47 from 4 : (i519) -> i515
    %51 = comb.mux %48, %49, %50 : i515
    %52 = comb.extract %22 from 1 : (i9) -> i1
    %53 = comb.extract %51 from 0 : (i515) -> i513
    %54 = comb.extract %51 from 2 : (i515) -> i513
    %55 = comb.mux %52, %53, %54 : i513
    %56 = comb.extract %22 from 0 : (i9) -> i1
    %57 = comb.extract %55 from 0 : (i513) -> i512
    %58 = comb.extract %55 from 1 : (i513) -> i512
    %59 = comb.mux %56, %57, %58 : i512
    %60 = comb.icmp sgt %22, %c40_i9 : i9
    %61 = comb.replicate %14 : (i1) -> i45
    %62 = comb.concat %61, %59 : i45, i512
    %63 = comb.mux %24, %c0_i557, %62 : i557
    %64 = comb.or %60, %4, %11, %66 : i1
    %65 = sv.reg : !hw.inout<i1> 
    %66 = sv.read_inout %65 : !hw.inout<i1>
    sv.alwaysff(posedge %clk) {
      sv.passign %65, %64 : i1
    }(syncreset : posedge %reset) {
      sv.passign %65, %false : i1
    }
    %67 = comb.extract %63 from 0 : (i557) -> i16
    %68 = comb.concat %false, %67 : i1, i16
    %69 = comb.concat %c0_i16, %14 : i16, i1
    %70 = comb.extract %74 from 0 : (i17) -> i16
    %71 = comb.concat %false, %70 : i1, i16
    %72 = comb.add %71, %68, %69 : i17
    %73 = sv.reg : !hw.inout<i17> 
    %74 = sv.read_inout %73 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %73, %72 : i17
    }(syncreset : posedge %reset) {
      sv.passign %73, %c0_i17 : i17
    }
    %75 = comb.extract %74 from 16 : (i17) -> i1
    %76 = comb.extract %63 from 16 : (i557) -> i16
    %77 = comb.concat %false, %76 : i1, i16
    %78 = comb.concat %c0_i16, %75 : i16, i1
    %79 = comb.extract %83 from 0 : (i17) -> i16
    %80 = comb.concat %false, %79 : i1, i16
    %81 = comb.add %80, %77, %78 : i17
    %82 = sv.reg : !hw.inout<i17> 
    %83 = sv.read_inout %82 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %82, %81 : i17
    }(syncreset : posedge %reset) {
      sv.passign %82, %c0_i17 : i17
    }
    %84 = comb.extract %83 from 16 : (i17) -> i1
    %85 = comb.extract %63 from 32 : (i557) -> i16
    %86 = comb.concat %false, %85 : i1, i16
    %87 = comb.concat %c0_i16, %84 : i16, i1
    %88 = comb.extract %92 from 0 : (i17) -> i16
    %89 = comb.concat %false, %88 : i1, i16
    %90 = comb.add %89, %86, %87 : i17
    %91 = sv.reg : !hw.inout<i17> 
    %92 = sv.read_inout %91 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %91, %90 : i17
    }(syncreset : posedge %reset) {
      sv.passign %91, %c0_i17 : i17
    }
    %93 = comb.extract %92 from 16 : (i17) -> i1
    %94 = comb.extract %63 from 48 : (i557) -> i16
    %95 = comb.concat %false, %94 : i1, i16
    %96 = comb.concat %c0_i16, %93 : i16, i1
    %97 = comb.extract %101 from 0 : (i17) -> i16
    %98 = comb.concat %false, %97 : i1, i16
    %99 = comb.add %98, %95, %96 : i17
    %100 = sv.reg : !hw.inout<i17> 
    %101 = sv.read_inout %100 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %100, %99 : i17
    }(syncreset : posedge %reset) {
      sv.passign %100, %c0_i17 : i17
    }
    %102 = comb.extract %101 from 16 : (i17) -> i1
    %103 = comb.extract %63 from 64 : (i557) -> i16
    %104 = comb.concat %false, %103 : i1, i16
    %105 = comb.concat %c0_i16, %102 : i16, i1
    %106 = comb.extract %110 from 0 : (i17) -> i16
    %107 = comb.concat %false, %106 : i1, i16
    %108 = comb.add %107, %104, %105 : i17
    %109 = sv.reg : !hw.inout<i17> 
    %110 = sv.read_inout %109 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %109, %108 : i17
    }(syncreset : posedge %reset) {
      sv.passign %109, %c0_i17 : i17
    }
    %111 = comb.extract %110 from 16 : (i17) -> i1
    %112 = comb.extract %63 from 80 : (i557) -> i16
    %113 = comb.concat %false, %112 : i1, i16
    %114 = comb.concat %c0_i16, %111 : i16, i1
    %115 = comb.extract %119 from 0 : (i17) -> i16
    %116 = comb.concat %false, %115 : i1, i16
    %117 = comb.add %116, %113, %114 : i17
    %118 = sv.reg : !hw.inout<i17> 
    %119 = sv.read_inout %118 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %118, %117 : i17
    }(syncreset : posedge %reset) {
      sv.passign %118, %c0_i17 : i17
    }
    %120 = comb.extract %119 from 16 : (i17) -> i1
    %121 = comb.extract %63 from 96 : (i557) -> i16
    %122 = comb.concat %false, %121 : i1, i16
    %123 = comb.concat %c0_i16, %120 : i16, i1
    %124 = comb.extract %128 from 0 : (i17) -> i16
    %125 = comb.concat %false, %124 : i1, i16
    %126 = comb.add %125, %122, %123 : i17
    %127 = sv.reg : !hw.inout<i17> 
    %128 = sv.read_inout %127 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %127, %126 : i17
    }(syncreset : posedge %reset) {
      sv.passign %127, %c0_i17 : i17
    }
    %129 = comb.extract %128 from 16 : (i17) -> i1
    %130 = comb.extract %63 from 112 : (i557) -> i16
    %131 = comb.concat %false, %130 : i1, i16
    %132 = comb.concat %c0_i16, %129 : i16, i1
    %133 = comb.extract %137 from 0 : (i17) -> i16
    %134 = comb.concat %false, %133 : i1, i16
    %135 = comb.add %134, %131, %132 : i17
    %136 = sv.reg : !hw.inout<i17> 
    %137 = sv.read_inout %136 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %136, %135 : i17
    }(syncreset : posedge %reset) {
      sv.passign %136, %c0_i17 : i17
    }
    %138 = comb.extract %137 from 16 : (i17) -> i1
    %139 = comb.extract %63 from 128 : (i557) -> i16
    %140 = comb.concat %false, %139 : i1, i16
    %141 = comb.concat %c0_i16, %138 : i16, i1
    %142 = comb.extract %146 from 0 : (i17) -> i16
    %143 = comb.concat %false, %142 : i1, i16
    %144 = comb.add %143, %140, %141 : i17
    %145 = sv.reg : !hw.inout<i17> 
    %146 = sv.read_inout %145 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %145, %144 : i17
    }(syncreset : posedge %reset) {
      sv.passign %145, %c0_i17 : i17
    }
    %147 = comb.extract %146 from 16 : (i17) -> i1
    %148 = comb.extract %63 from 144 : (i557) -> i16
    %149 = comb.concat %false, %148 : i1, i16
    %150 = comb.concat %c0_i16, %147 : i16, i1
    %151 = comb.extract %155 from 0 : (i17) -> i16
    %152 = comb.concat %false, %151 : i1, i16
    %153 = comb.add %152, %149, %150 : i17
    %154 = sv.reg : !hw.inout<i17> 
    %155 = sv.read_inout %154 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %154, %153 : i17
    }(syncreset : posedge %reset) {
      sv.passign %154, %c0_i17 : i17
    }
    %156 = comb.extract %155 from 16 : (i17) -> i1
    %157 = comb.extract %63 from 160 : (i557) -> i16
    %158 = comb.concat %false, %157 : i1, i16
    %159 = comb.concat %c0_i16, %156 : i16, i1
    %160 = comb.extract %164 from 0 : (i17) -> i16
    %161 = comb.concat %false, %160 : i1, i16
    %162 = comb.add %161, %158, %159 : i17
    %163 = sv.reg : !hw.inout<i17> 
    %164 = sv.read_inout %163 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %163, %162 : i17
    }(syncreset : posedge %reset) {
      sv.passign %163, %c0_i17 : i17
    }
    %165 = comb.extract %164 from 16 : (i17) -> i1
    %166 = comb.extract %63 from 176 : (i557) -> i16
    %167 = comb.concat %false, %166 : i1, i16
    %168 = comb.concat %c0_i16, %165 : i16, i1
    %169 = comb.extract %173 from 0 : (i17) -> i16
    %170 = comb.concat %false, %169 : i1, i16
    %171 = comb.add %170, %167, %168 : i17
    %172 = sv.reg : !hw.inout<i17> 
    %173 = sv.read_inout %172 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %172, %171 : i17
    }(syncreset : posedge %reset) {
      sv.passign %172, %c0_i17 : i17
    }
    %174 = comb.extract %173 from 16 : (i17) -> i1
    %175 = comb.extract %63 from 192 : (i557) -> i16
    %176 = comb.concat %false, %175 : i1, i16
    %177 = comb.concat %c0_i16, %174 : i16, i1
    %178 = comb.extract %182 from 0 : (i17) -> i16
    %179 = comb.concat %false, %178 : i1, i16
    %180 = comb.add %179, %176, %177 : i17
    %181 = sv.reg : !hw.inout<i17> 
    %182 = sv.read_inout %181 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %181, %180 : i17
    }(syncreset : posedge %reset) {
      sv.passign %181, %c0_i17 : i17
    }
    %183 = comb.extract %182 from 16 : (i17) -> i1
    %184 = comb.extract %63 from 208 : (i557) -> i16
    %185 = comb.concat %false, %184 : i1, i16
    %186 = comb.concat %c0_i16, %183 : i16, i1
    %187 = comb.extract %191 from 0 : (i17) -> i16
    %188 = comb.concat %false, %187 : i1, i16
    %189 = comb.add %188, %185, %186 : i17
    %190 = sv.reg : !hw.inout<i17> 
    %191 = sv.read_inout %190 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %190, %189 : i17
    }(syncreset : posedge %reset) {
      sv.passign %190, %c0_i17 : i17
    }
    %192 = comb.extract %191 from 16 : (i17) -> i1
    %193 = comb.extract %63 from 224 : (i557) -> i16
    %194 = comb.concat %false, %193 : i1, i16
    %195 = comb.concat %c0_i16, %192 : i16, i1
    %196 = comb.extract %200 from 0 : (i17) -> i16
    %197 = comb.concat %false, %196 : i1, i16
    %198 = comb.add %197, %194, %195 : i17
    %199 = sv.reg : !hw.inout<i17> 
    %200 = sv.read_inout %199 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %199, %198 : i17
    }(syncreset : posedge %reset) {
      sv.passign %199, %c0_i17 : i17
    }
    %201 = comb.extract %200 from 16 : (i17) -> i1
    %202 = comb.extract %63 from 240 : (i557) -> i16
    %203 = comb.concat %false, %202 : i1, i16
    %204 = comb.concat %c0_i16, %201 : i16, i1
    %205 = comb.extract %209 from 0 : (i17) -> i16
    %206 = comb.concat %false, %205 : i1, i16
    %207 = comb.add %206, %203, %204 : i17
    %208 = sv.reg : !hw.inout<i17> 
    %209 = sv.read_inout %208 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %208, %207 : i17
    }(syncreset : posedge %reset) {
      sv.passign %208, %c0_i17 : i17
    }
    %210 = comb.extract %209 from 16 : (i17) -> i1
    %211 = comb.extract %63 from 256 : (i557) -> i16
    %212 = comb.concat %false, %211 : i1, i16
    %213 = comb.concat %c0_i16, %210 : i16, i1
    %214 = comb.extract %218 from 0 : (i17) -> i16
    %215 = comb.concat %false, %214 : i1, i16
    %216 = comb.add %215, %212, %213 : i17
    %217 = sv.reg : !hw.inout<i17> 
    %218 = sv.read_inout %217 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %217, %216 : i17
    }(syncreset : posedge %reset) {
      sv.passign %217, %c0_i17 : i17
    }
    %219 = comb.extract %218 from 16 : (i17) -> i1
    %220 = comb.extract %63 from 272 : (i557) -> i16
    %221 = comb.concat %false, %220 : i1, i16
    %222 = comb.concat %c0_i16, %219 : i16, i1
    %223 = comb.extract %227 from 0 : (i17) -> i16
    %224 = comb.concat %false, %223 : i1, i16
    %225 = comb.add %224, %221, %222 : i17
    %226 = sv.reg : !hw.inout<i17> 
    %227 = sv.read_inout %226 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %226, %225 : i17
    }(syncreset : posedge %reset) {
      sv.passign %226, %c0_i17 : i17
    }
    %228 = comb.extract %227 from 16 : (i17) -> i1
    %229 = comb.extract %63 from 288 : (i557) -> i16
    %230 = comb.concat %false, %229 : i1, i16
    %231 = comb.concat %c0_i16, %228 : i16, i1
    %232 = comb.extract %236 from 0 : (i17) -> i16
    %233 = comb.concat %false, %232 : i1, i16
    %234 = comb.add %233, %230, %231 : i17
    %235 = sv.reg : !hw.inout<i17> 
    %236 = sv.read_inout %235 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %235, %234 : i17
    }(syncreset : posedge %reset) {
      sv.passign %235, %c0_i17 : i17
    }
    %237 = comb.extract %236 from 16 : (i17) -> i1
    %238 = comb.extract %63 from 304 : (i557) -> i16
    %239 = comb.concat %false, %238 : i1, i16
    %240 = comb.concat %c0_i16, %237 : i16, i1
    %241 = comb.extract %245 from 0 : (i17) -> i16
    %242 = comb.concat %false, %241 : i1, i16
    %243 = comb.add %242, %239, %240 : i17
    %244 = sv.reg : !hw.inout<i17> 
    %245 = sv.read_inout %244 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %244, %243 : i17
    }(syncreset : posedge %reset) {
      sv.passign %244, %c0_i17 : i17
    }
    %246 = comb.extract %245 from 16 : (i17) -> i1
    %247 = comb.extract %63 from 320 : (i557) -> i16
    %248 = comb.concat %false, %247 : i1, i16
    %249 = comb.concat %c0_i16, %246 : i16, i1
    %250 = comb.extract %254 from 0 : (i17) -> i16
    %251 = comb.concat %false, %250 : i1, i16
    %252 = comb.add %251, %248, %249 : i17
    %253 = sv.reg : !hw.inout<i17> 
    %254 = sv.read_inout %253 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %253, %252 : i17
    }(syncreset : posedge %reset) {
      sv.passign %253, %c0_i17 : i17
    }
    %255 = comb.extract %254 from 16 : (i17) -> i1
    %256 = comb.extract %63 from 336 : (i557) -> i16
    %257 = comb.concat %false, %256 : i1, i16
    %258 = comb.concat %c0_i16, %255 : i16, i1
    %259 = comb.extract %263 from 0 : (i17) -> i16
    %260 = comb.concat %false, %259 : i1, i16
    %261 = comb.add %260, %257, %258 : i17
    %262 = sv.reg : !hw.inout<i17> 
    %263 = sv.read_inout %262 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %262, %261 : i17
    }(syncreset : posedge %reset) {
      sv.passign %262, %c0_i17 : i17
    }
    %264 = comb.extract %263 from 16 : (i17) -> i1
    %265 = comb.extract %63 from 352 : (i557) -> i16
    %266 = comb.concat %false, %265 : i1, i16
    %267 = comb.concat %c0_i16, %264 : i16, i1
    %268 = comb.extract %272 from 0 : (i17) -> i16
    %269 = comb.concat %false, %268 : i1, i16
    %270 = comb.add %269, %266, %267 : i17
    %271 = sv.reg : !hw.inout<i17> 
    %272 = sv.read_inout %271 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %271, %270 : i17
    }(syncreset : posedge %reset) {
      sv.passign %271, %c0_i17 : i17
    }
    %273 = comb.extract %272 from 16 : (i17) -> i1
    %274 = comb.extract %63 from 368 : (i557) -> i16
    %275 = comb.concat %false, %274 : i1, i16
    %276 = comb.concat %c0_i16, %273 : i16, i1
    %277 = comb.extract %281 from 0 : (i17) -> i16
    %278 = comb.concat %false, %277 : i1, i16
    %279 = comb.add %278, %275, %276 : i17
    %280 = sv.reg : !hw.inout<i17> 
    %281 = sv.read_inout %280 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %280, %279 : i17
    }(syncreset : posedge %reset) {
      sv.passign %280, %c0_i17 : i17
    }
    %282 = comb.extract %281 from 16 : (i17) -> i1
    %283 = comb.extract %63 from 384 : (i557) -> i16
    %284 = comb.concat %false, %283 : i1, i16
    %285 = comb.concat %c0_i16, %282 : i16, i1
    %286 = comb.extract %290 from 0 : (i17) -> i16
    %287 = comb.concat %false, %286 : i1, i16
    %288 = comb.add %287, %284, %285 : i17
    %289 = sv.reg : !hw.inout<i17> 
    %290 = sv.read_inout %289 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %289, %288 : i17
    }(syncreset : posedge %reset) {
      sv.passign %289, %c0_i17 : i17
    }
    %291 = comb.extract %290 from 16 : (i17) -> i1
    %292 = comb.extract %63 from 400 : (i557) -> i16
    %293 = comb.concat %false, %292 : i1, i16
    %294 = comb.concat %c0_i16, %291 : i16, i1
    %295 = comb.extract %299 from 0 : (i17) -> i16
    %296 = comb.concat %false, %295 : i1, i16
    %297 = comb.add %296, %293, %294 : i17
    %298 = sv.reg : !hw.inout<i17> 
    %299 = sv.read_inout %298 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %298, %297 : i17
    }(syncreset : posedge %reset) {
      sv.passign %298, %c0_i17 : i17
    }
    %300 = comb.extract %299 from 16 : (i17) -> i1
    %301 = comb.extract %63 from 416 : (i557) -> i16
    %302 = comb.concat %false, %301 : i1, i16
    %303 = comb.concat %c0_i16, %300 : i16, i1
    %304 = comb.extract %308 from 0 : (i17) -> i16
    %305 = comb.concat %false, %304 : i1, i16
    %306 = comb.add %305, %302, %303 : i17
    %307 = sv.reg : !hw.inout<i17> 
    %308 = sv.read_inout %307 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %307, %306 : i17
    }(syncreset : posedge %reset) {
      sv.passign %307, %c0_i17 : i17
    }
    %309 = comb.extract %308 from 16 : (i17) -> i1
    %310 = comb.extract %63 from 432 : (i557) -> i16
    %311 = comb.concat %false, %310 : i1, i16
    %312 = comb.concat %c0_i16, %309 : i16, i1
    %313 = comb.extract %317 from 0 : (i17) -> i16
    %314 = comb.concat %false, %313 : i1, i16
    %315 = comb.add %314, %311, %312 : i17
    %316 = sv.reg : !hw.inout<i17> 
    %317 = sv.read_inout %316 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %316, %315 : i17
    }(syncreset : posedge %reset) {
      sv.passign %316, %c0_i17 : i17
    }
    %318 = comb.extract %317 from 16 : (i17) -> i1
    %319 = comb.extract %63 from 448 : (i557) -> i16
    %320 = comb.concat %false, %319 : i1, i16
    %321 = comb.concat %c0_i16, %318 : i16, i1
    %322 = comb.extract %326 from 0 : (i17) -> i16
    %323 = comb.concat %false, %322 : i1, i16
    %324 = comb.add %323, %320, %321 : i17
    %325 = sv.reg : !hw.inout<i17> 
    %326 = sv.read_inout %325 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %325, %324 : i17
    }(syncreset : posedge %reset) {
      sv.passign %325, %c0_i17 : i17
    }
    %327 = comb.extract %326 from 16 : (i17) -> i1
    %328 = comb.extract %63 from 464 : (i557) -> i16
    %329 = comb.concat %false, %328 : i1, i16
    %330 = comb.concat %c0_i16, %327 : i16, i1
    %331 = comb.extract %335 from 0 : (i17) -> i16
    %332 = comb.concat %false, %331 : i1, i16
    %333 = comb.add %332, %329, %330 : i17
    %334 = sv.reg : !hw.inout<i17> 
    %335 = sv.read_inout %334 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %334, %333 : i17
    }(syncreset : posedge %reset) {
      sv.passign %334, %c0_i17 : i17
    }
    %336 = comb.extract %335 from 16 : (i17) -> i1
    %337 = comb.extract %63 from 480 : (i557) -> i16
    %338 = comb.concat %false, %337 : i1, i16
    %339 = comb.concat %c0_i16, %336 : i16, i1
    %340 = comb.extract %344 from 0 : (i17) -> i16
    %341 = comb.concat %false, %340 : i1, i16
    %342 = comb.add %341, %338, %339 : i17
    %343 = sv.reg : !hw.inout<i17> 
    %344 = sv.read_inout %343 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %343, %342 : i17
    }(syncreset : posedge %reset) {
      sv.passign %343, %c0_i17 : i17
    }
    %345 = comb.extract %344 from 16 : (i17) -> i1
    %346 = comb.extract %63 from 496 : (i557) -> i16
    %347 = comb.concat %false, %346 : i1, i16
    %348 = comb.concat %c0_i16, %345 : i16, i1
    %349 = comb.extract %353 from 0 : (i17) -> i16
    %350 = comb.concat %false, %349 : i1, i16
    %351 = comb.add %350, %347, %348 : i17
    %352 = sv.reg : !hw.inout<i17> 
    %353 = sv.read_inout %352 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %352, %351 : i17
    }(syncreset : posedge %reset) {
      sv.passign %352, %c0_i17 : i17
    }
    %354 = comb.extract %353 from 16 : (i17) -> i1
    %355 = comb.extract %63 from 512 : (i557) -> i16
    %356 = comb.concat %false, %355 : i1, i16
    %357 = comb.concat %c0_i16, %354 : i16, i1
    %358 = comb.extract %362 from 0 : (i17) -> i16
    %359 = comb.concat %false, %358 : i1, i16
    %360 = comb.add %359, %356, %357 : i17
    %361 = sv.reg : !hw.inout<i17> 
    %362 = sv.read_inout %361 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %361, %360 : i17
    }(syncreset : posedge %reset) {
      sv.passign %361, %c0_i17 : i17
    }
    %363 = comb.extract %362 from 16 : (i17) -> i1
    %364 = comb.extract %63 from 528 : (i557) -> i16
    %365 = comb.concat %false, %364 : i1, i16
    %366 = comb.concat %c0_i16, %363 : i16, i1
    %367 = comb.extract %371 from 0 : (i17) -> i16
    %368 = comb.concat %false, %367 : i1, i16
    %369 = comb.add %368, %365, %366 : i17
    %370 = sv.reg : !hw.inout<i17> 
    %371 = sv.read_inout %370 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %370, %369 : i17
    }(syncreset : posedge %reset) {
      sv.passign %370, %c0_i17 : i17
    }
    %372 = comb.extract %371 from 16 : (i17) -> i1
    %373 = comb.extract %63 from 544 : (i557) -> i13
    %374 = comb.concat %false, %373 : i1, i13
    %375 = comb.concat %c0_i13, %372 : i13, i1
    %376 = comb.extract %380 from 0 : (i14) -> i13
    %377 = comb.concat %false, %376 : i1, i13
    %378 = comb.add %377, %374, %375 : i14
    %379 = sv.reg : !hw.inout<i14> 
    %380 = sv.read_inout %379 : !hw.inout<i14>
    sv.alwaysff(posedge %clk) {
      sv.passign %379, %378 : i14
    }(syncreset : posedge %reset) {
      sv.passign %379, %c0_i14 : i14
    }
    %381 = comb.concat %376, %367, %358, %349, %340, %331, %322, %313, %304, %295, %286, %277, %268, %259, %250, %241, %232, %223, %214, %205, %196, %187, %178, %169, %160, %151, %142, %133, %124, %115, %106, %97, %88, %79, %70 : i13, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16
    %382 = comb.concat %c0_i12, %372, %c0_i15, %363, %c0_i15, %354, %c0_i15, %345, %c0_i15, %336, %c0_i15, %327, %c0_i15, %318, %c0_i15, %309, %c0_i15, %300, %c0_i15, %291, %c0_i15, %282, %c0_i15, %273, %c0_i15, %264, %c0_i15, %255, %c0_i15, %246, %c0_i15, %237, %c0_i15, %228, %c0_i15, %219, %c0_i15, %210, %c0_i15, %201, %c0_i15, %192, %c0_i15, %183, %c0_i15, %174, %c0_i15, %165, %c0_i15, %156, %c0_i15, %147, %c0_i15, %138, %c0_i15, %129, %c0_i15, %120, %c0_i15, %111, %c0_i15, %102, %c0_i15, %93, %c0_i15, %84, %c0_i15, %75, %c0_i16 : i12, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i16
    %383 = comb.add %381, %382 : i557
    %384 = comb.icmp eq %383, %c0_i557 : i557
    %385 = comb.extract %383 from 556 : (i557) -> i1
    %386 = comb.xor %383, %c-1_i557 : i557
    %387 = comb.add %386, %c1_i557 : i557
    %388 = comb.mux %385, %387, %383 : i557
    %389 = comb.extract %388 from 45 : (i557) -> i512
    %390 = comb.icmp eq %389, %c0_i512 : i512
    %391 = comb.extract %388 from 0 : (i557) -> i45
    %392 = comb.concat %391, %c0_i466 : i45, i466
    %393 = comb.extract %388 from 46 : (i557) -> i511
    %394 = comb.mux %390, %392, %393 : i511
    %395 = comb.extract %394 from 255 : (i511) -> i256
    %396 = comb.icmp eq %395, %c0_i256 : i256
    %397 = comb.extract %394 from 0 : (i511) -> i255
    %398 = comb.extract %394 from 256 : (i511) -> i255
    %399 = comb.mux %396, %397, %398 : i255
    %400 = comb.extract %399 from 127 : (i255) -> i128
    %401 = comb.icmp eq %400, %c0_i128 : i128
    %402 = comb.extract %399 from 0 : (i255) -> i127
    %403 = comb.extract %399 from 128 : (i255) -> i127
    %404 = comb.mux %401, %402, %403 : i127
    %405 = comb.extract %404 from 63 : (i127) -> i64
    %406 = comb.icmp eq %405, %c0_i64 : i64
    %407 = comb.extract %404 from 0 : (i127) -> i63
    %408 = comb.extract %404 from 64 : (i127) -> i63
    %409 = comb.mux %406, %407, %408 : i63
    %410 = comb.extract %409 from 31 : (i63) -> i32
    %411 = comb.icmp eq %410, %c0_i32 : i32
    %412 = comb.extract %409 from 0 : (i63) -> i31
    %413 = comb.extract %409 from 32 : (i63) -> i31
    %414 = comb.mux %411, %412, %413 : i31
    %415 = comb.extract %414 from 15 : (i31) -> i16
    %416 = comb.icmp eq %415, %c0_i16 : i16
    %417 = comb.extract %414 from 0 : (i31) -> i15
    %418 = comb.extract %414 from 16 : (i31) -> i15
    %419 = comb.mux %416, %417, %418 : i15
    %420 = comb.extract %419 from 7 : (i15) -> i8
    %421 = comb.icmp eq %420, %c0_i8 : i8
    %422 = comb.extract %419 from 0 : (i15) -> i7
    %423 = comb.extract %419 from 8 : (i15) -> i7
    %424 = comb.mux %421, %422, %423 : i7
    %425 = comb.extract %424 from 3 : (i7) -> i4
    %426 = comb.icmp eq %425, %c0_i4 : i4
    %427 = comb.extract %424 from 0 : (i7) -> i3
    %428 = comb.extract %424 from 4 : (i7) -> i3
    %429 = comb.mux %426, %427, %428 : i3
    %430 = comb.extract %429 from 1 : (i3) -> i2
    %431 = comb.icmp eq %430, %c0_i2 : i2
    %432 = comb.extract %429 from 0 : (i3) -> i1
    %433 = comb.extract %429 from 2 : (i3) -> i1
    %434 = comb.mux %431, %432, %433 : i1
    %435 = comb.xor %434, %true : i1
    %436 = comb.extract %388 from 0 : (i557) -> i44
    %437 = comb.concat %436, %c0_i512 : i44, i512
    %438 = comb.extract %388 from 0 : (i557) -> i556
    %439 = comb.mux %390, %437, %438 : i556
    %440 = comb.extract %439 from 0 : (i556) -> i300
    %441 = comb.concat %440, %c0_i256 : i300, i256
    %442 = comb.mux %396, %441, %439 : i556
    %443 = comb.extract %442 from 0 : (i556) -> i428
    %444 = comb.concat %443, %c0_i128 : i428, i128
    %445 = comb.mux %401, %444, %442 : i556
    %446 = comb.extract %445 from 0 : (i556) -> i492
    %447 = comb.concat %446, %c0_i64 : i492, i64
    %448 = comb.mux %406, %447, %445 : i556
    %449 = comb.extract %448 from 0 : (i556) -> i524
    %450 = comb.concat %449, %c0_i32 : i524, i32
    %451 = comb.mux %411, %450, %448 : i556
    %452 = comb.extract %451 from 0 : (i556) -> i540
    %453 = comb.concat %452, %c0_i16 : i540, i16
    %454 = comb.mux %416, %453, %451 : i556
    %455 = comb.extract %454 from 0 : (i556) -> i548
    %456 = comb.concat %455, %c0_i8 : i548, i8
    %457 = comb.mux %421, %456, %454 : i556
    %458 = comb.extract %457 from 0 : (i556) -> i552
    %459 = comb.concat %458, %c0_i4 : i552, i4
    %460 = comb.mux %426, %459, %457 : i556
    %461 = comb.extract %460 from 0 : (i556) -> i554
    %462 = comb.concat %461, %c0_i2 : i554, i2
    %463 = comb.mux %431, %462, %460 : i556
    %464 = comb.extract %463 from 0 : (i556) -> i555
    %465 = comb.concat %464, %false : i555, i1
    %466 = comb.mux %435, %465, %463 : i556
    %467 = comb.extract %466 from 0 : (i556) -> i531
    %468 = comb.icmp ne %467, %c0_i531 : i531
    %469 = comb.concat %c0_i2, %390, %396, %401, %406, %411, %416, %421, %426, %431, %435 : i2, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
    %470 = comb.sub %c258_i12, %469 : i12
    %471 = comb.extract %466 from 533 : (i556) -> i23
    %472 = comb.extract %466 from 532 : (i556) -> i1
    %473 = comb.extract %466 from 531 : (i556) -> i1
    %474 = comb.extract %466 from 533 : (i556) -> i1
    %475 = comb.or %473, %468, %474 : i1
    %476 = comb.and %472, %475 : i1
    %477 = comb.concat %c0_i24, %476 : i24, i1
    %478 = comb.concat %c1_i2, %471 : i2, i23
    %479 = comb.add %478, %477 : i25
    %480 = comb.extract %479 from 24 : (i25) -> i1
    %481 = comb.extract %479 from 1 : (i25) -> i23
    %482 = comb.extract %479 from 0 : (i25) -> i23
    %483 = comb.mux %480, %481, %482 : i23
    %484 = comb.concat %c0_i11, %480 : i11, i1
    %485 = comb.add %470, %484, %c127_i12 : i12
    %486 = comb.icmp slt %485, %c1_i12 : i12
    %487 = comb.icmp sgt %485, %c254_i12 : i12
    %488 = comb.extract %485 from 0 : (i12) -> i8
    %489 = comb.or %486, %384 : i1
    %490 = comb.mux %489, %c0_i8, %488 : i8
    %491 = comb.mux %487, %c-1_i8, %490 : i8
    %492 = comb.or %486, %384, %487 : i1
    %493 = comb.mux %492, %c0_i23, %483 : i23
    %494 = comb.concat %385, %491, %493 : i1, i8, i23
    %495 = comb.mux %66, %c2143289344_i32, %494 : i32
    hw.output %495 : i32
  }
}

