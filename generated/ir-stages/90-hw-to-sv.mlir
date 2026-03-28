module {
  hw.module @fpmult_loop_muladd_s3fdp(in %clk : i1 {hw.name = "clk"}, in %reset : i1 {hw.name = "reset"}, in %a : !hw.array<2xi16> {hw.name = "a"}, in %b : !hw.array<2xi16> {hw.name = "b"}, in %c : !hw.array<2xi16> {hw.name = "c"}, in %clk_0 : i1, out r : i16 {hw.name = "r"}) {
    %true = hw.constant true
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %0 = hw.bitcast %b : (!hw.array<2xi16>) -> i32
    %1 = hw.bitcast %a : (!hw.array<2xi16>) -> i32
    %c_mem = sv.reg : !hw.inout<uarray<2xi16>> 
    sv.alwaysff(posedge %clk_0) {
      sv.if %4 {
        %24 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi16>>, i1
        sv.passign %24, %s3fdp_accum.r : i16
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
    %13 = comb.extract %1 from 0 : (i32) -> i16
    %14 = comb.extract %1 from 16 : (i32) -> i16
    %15 = comb.mux %12, %14, %13 : i16
    %16 = comb.extract %0 from 0 : (i32) -> i16
    %17 = comb.extract %0 from 16 : (i32) -> i16
    %18 = comb.mux %12, %17, %16 : i16
    %cg_en_latch = sv.reg : !hw.inout<i1> 
    sv.always  {
      %24 = comb.xor %clk, %true : i1
      sv.if %24 {
        sv.passign %cg_en_latch, %4 : i1
      }
    }
    %19 = sv.read_inout %cg_en_latch : !hw.inout<i1>
    %20 = comb.and %clk, %19 : i1
    %s3fdp_accum.r = hw.instance "s3fdp_accum" @s3fdp_accum_core_wE8_wF7_cs16(clk: %20: i1, reset: %reset: i1, x: %15: i16, y: %18: i16) -> (r: i16)
    %21 = comb.mux %11, %c0_i32, %3 : i32
    %22 = sv.array_index_inout %c_mem[%false] : !hw.inout<uarray<2xi16>>, i1
    %23 = sv.read_inout %22 : !hw.inout<i16>
    hw.output %23 : i16
  }
  hw.module @s3fdp_accum_core_wE8_wF7_cs16(in %clk : i1, in %reset : i1, in %x : i16, in %y : i16, out r : i16) {
    %c0_i265 = hw.constant 0 : i265
    %c0_i245 = hw.constant 0 : i245
    %c32704_i16 = hw.constant 32704 : i16
    %c1_i11 = hw.constant 1 : i11
    %c1_i2 = hw.constant 1 : i2
    %c0_i9 = hw.constant 0 : i9
    %c-120_i9 = hw.constant -120 : i9
    %c254_i11 = hw.constant 254 : i11
    %c0_i7 = hw.constant 0 : i7
    %c127_i11 = hw.constant 127 : i11
    %c132_i11 = hw.constant 132 : i11
    %c1_i266 = hw.constant 1 : i266
    %c-1_i266 = hw.constant -1 : i266
    %c0_i15 = hw.constant 0 : i15
    %c0_i11 = hw.constant 0 : i11
    %c0_i10 = hw.constant 0 : i10
    %c0_i17 = hw.constant 0 : i17
    %c0_i266 = hw.constant 0 : i266
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %c0_i32 = hw.constant 0 : i32
    %c0_i64 = hw.constant 0 : i64
    %c0_i128 = hw.constant 0 : i128
    %c0_i256 = hw.constant 0 : i256
    %false = hw.constant false
    %c1_i8 = hw.constant 1 : i8
    %true = hw.constant true
    %c-1_i8 = hw.constant -1 : i8
    %c0_i8 = hw.constant 0 : i8
    %c0_i16 = hw.constant 0 : i16
    %0 = comb.extract %x from 15 : (i16) -> i1
    %1 = comb.extract %x from 7 : (i16) -> i8
    %2 = comb.extract %x from 0 : (i16) -> i7
    %3 = comb.icmp eq %1, %c0_i8 : i8
    %4 = comb.icmp eq %1, %c-1_i8 : i8
    %5 = comb.xor %3, %true : i1
    %6 = comb.mux %3, %c1_i8, %1 : i8
    %7 = comb.extract %y from 15 : (i16) -> i1
    %8 = comb.extract %y from 7 : (i16) -> i8
    %9 = comb.extract %y from 0 : (i16) -> i7
    %10 = comb.icmp eq %8, %c0_i8 : i8
    %11 = comb.icmp eq %8, %c-1_i8 : i8
    %12 = comb.xor %10, %true : i1
    %13 = comb.mux %10, %c1_i8, %8 : i8
    %14 = comb.xor %0, %7 : i1
    %15 = comb.concat %c0_i8, %5, %2 : i8, i1, i7
    %16 = comb.concat %c0_i8, %12, %9 : i8, i1, i7
    %17 = comb.mul %15, %16 : i16
    %18 = comb.concat %false, %13 : i1, i8
    %19 = comb.concat %false, %6 : i1, i8
    %20 = comb.replicate %14 : (i1) -> i16
    %21 = comb.xor %20, %17 : i16
    %22 = comb.add %19, %18, %c-120_i9 : i9
    %23 = comb.extract %22 from 8 : (i9) -> i1
    %24 = comb.concat %c0_i9, %21, %c0_i256 : i9, i16, i256
    %25 = comb.concat %c0_i265, %21 : i265, i16
    %26 = comb.mux %23, %24, %25 : i281
    %27 = comb.extract %22 from 7 : (i9) -> i1
    %28 = comb.extract %26 from 0 : (i281) -> i153
    %29 = comb.concat %28, %c0_i128 : i153, i128
    %30 = comb.mux %27, %29, %26 : i281
    %31 = comb.extract %22 from 6 : (i9) -> i1
    %32 = comb.extract %30 from 0 : (i281) -> i217
    %33 = comb.concat %32, %c0_i64 : i217, i64
    %34 = comb.mux %31, %33, %30 : i281
    %35 = comb.extract %22 from 5 : (i9) -> i1
    %36 = comb.extract %34 from 0 : (i281) -> i249
    %37 = comb.concat %36, %c0_i32 : i249, i32
    %38 = comb.mux %35, %37, %34 : i281
    %39 = comb.extract %22 from 4 : (i9) -> i1
    %40 = comb.extract %38 from 0 : (i281) -> i265
    %41 = comb.concat %40, %c0_i16 : i265, i16
    %42 = comb.mux %39, %41, %38 : i281
    %43 = comb.extract %22 from 3 : (i9) -> i1
    %44 = comb.extract %42 from 0 : (i281) -> i273
    %45 = comb.extract %42 from 8 : (i281) -> i273
    %46 = comb.mux %43, %44, %45 : i273
    %47 = comb.extract %22 from 2 : (i9) -> i1
    %48 = comb.extract %46 from 0 : (i273) -> i269
    %49 = comb.extract %46 from 4 : (i273) -> i269
    %50 = comb.mux %47, %48, %49 : i269
    %51 = comb.extract %22 from 1 : (i9) -> i1
    %52 = comb.extract %50 from 0 : (i269) -> i267
    %53 = comb.extract %50 from 2 : (i269) -> i267
    %54 = comb.mux %51, %52, %53 : i267
    %55 = comb.extract %22 from 0 : (i9) -> i1
    %56 = comb.extract %54 from 0 : (i267) -> i266
    %57 = comb.extract %54 from 1 : (i267) -> i266
    %58 = comb.mux %55, %56, %57 : i266
    %59 = comb.mux %23, %c0_i266, %58 : i266
    %60 = comb.or %4, %11, %62 : i1
    %61 = sv.reg : !hw.inout<i1> 
    %62 = sv.read_inout %61 : !hw.inout<i1>
    sv.alwaysff(posedge %clk) {
      sv.passign %61, %60 : i1
    }(syncreset : posedge %reset) {
      sv.passign %61, %false : i1
    }
    %63 = comb.extract %59 from 0 : (i266) -> i16
    %64 = comb.concat %false, %63 : i1, i16
    %65 = comb.concat %c0_i16, %14 : i16, i1
    %66 = comb.extract %70 from 0 : (i17) -> i16
    %67 = comb.concat %false, %66 : i1, i16
    %68 = comb.add %67, %64, %65 : i17
    %69 = sv.reg : !hw.inout<i17> 
    %70 = sv.read_inout %69 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %69, %68 : i17
    }(syncreset : posedge %reset) {
      sv.passign %69, %c0_i17 : i17
    }
    %71 = comb.extract %70 from 16 : (i17) -> i1
    %72 = comb.extract %59 from 16 : (i266) -> i16
    %73 = comb.concat %false, %72 : i1, i16
    %74 = comb.concat %c0_i16, %71 : i16, i1
    %75 = comb.extract %79 from 0 : (i17) -> i16
    %76 = comb.concat %false, %75 : i1, i16
    %77 = comb.add %76, %73, %74 : i17
    %78 = sv.reg : !hw.inout<i17> 
    %79 = sv.read_inout %78 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %78, %77 : i17
    }(syncreset : posedge %reset) {
      sv.passign %78, %c0_i17 : i17
    }
    %80 = comb.extract %79 from 16 : (i17) -> i1
    %81 = comb.extract %59 from 32 : (i266) -> i16
    %82 = comb.concat %false, %81 : i1, i16
    %83 = comb.concat %c0_i16, %80 : i16, i1
    %84 = comb.extract %88 from 0 : (i17) -> i16
    %85 = comb.concat %false, %84 : i1, i16
    %86 = comb.add %85, %82, %83 : i17
    %87 = sv.reg : !hw.inout<i17> 
    %88 = sv.read_inout %87 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %87, %86 : i17
    }(syncreset : posedge %reset) {
      sv.passign %87, %c0_i17 : i17
    }
    %89 = comb.extract %88 from 16 : (i17) -> i1
    %90 = comb.extract %59 from 48 : (i266) -> i16
    %91 = comb.concat %false, %90 : i1, i16
    %92 = comb.concat %c0_i16, %89 : i16, i1
    %93 = comb.extract %97 from 0 : (i17) -> i16
    %94 = comb.concat %false, %93 : i1, i16
    %95 = comb.add %94, %91, %92 : i17
    %96 = sv.reg : !hw.inout<i17> 
    %97 = sv.read_inout %96 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %96, %95 : i17
    }(syncreset : posedge %reset) {
      sv.passign %96, %c0_i17 : i17
    }
    %98 = comb.extract %97 from 16 : (i17) -> i1
    %99 = comb.extract %59 from 64 : (i266) -> i16
    %100 = comb.concat %false, %99 : i1, i16
    %101 = comb.concat %c0_i16, %98 : i16, i1
    %102 = comb.extract %106 from 0 : (i17) -> i16
    %103 = comb.concat %false, %102 : i1, i16
    %104 = comb.add %103, %100, %101 : i17
    %105 = sv.reg : !hw.inout<i17> 
    %106 = sv.read_inout %105 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %105, %104 : i17
    }(syncreset : posedge %reset) {
      sv.passign %105, %c0_i17 : i17
    }
    %107 = comb.extract %106 from 16 : (i17) -> i1
    %108 = comb.extract %59 from 80 : (i266) -> i16
    %109 = comb.concat %false, %108 : i1, i16
    %110 = comb.concat %c0_i16, %107 : i16, i1
    %111 = comb.extract %115 from 0 : (i17) -> i16
    %112 = comb.concat %false, %111 : i1, i16
    %113 = comb.add %112, %109, %110 : i17
    %114 = sv.reg : !hw.inout<i17> 
    %115 = sv.read_inout %114 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %114, %113 : i17
    }(syncreset : posedge %reset) {
      sv.passign %114, %c0_i17 : i17
    }
    %116 = comb.extract %115 from 16 : (i17) -> i1
    %117 = comb.extract %59 from 96 : (i266) -> i16
    %118 = comb.concat %false, %117 : i1, i16
    %119 = comb.concat %c0_i16, %116 : i16, i1
    %120 = comb.extract %124 from 0 : (i17) -> i16
    %121 = comb.concat %false, %120 : i1, i16
    %122 = comb.add %121, %118, %119 : i17
    %123 = sv.reg : !hw.inout<i17> 
    %124 = sv.read_inout %123 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %123, %122 : i17
    }(syncreset : posedge %reset) {
      sv.passign %123, %c0_i17 : i17
    }
    %125 = comb.extract %124 from 16 : (i17) -> i1
    %126 = comb.extract %59 from 112 : (i266) -> i16
    %127 = comb.concat %false, %126 : i1, i16
    %128 = comb.concat %c0_i16, %125 : i16, i1
    %129 = comb.extract %133 from 0 : (i17) -> i16
    %130 = comb.concat %false, %129 : i1, i16
    %131 = comb.add %130, %127, %128 : i17
    %132 = sv.reg : !hw.inout<i17> 
    %133 = sv.read_inout %132 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %132, %131 : i17
    }(syncreset : posedge %reset) {
      sv.passign %132, %c0_i17 : i17
    }
    %134 = comb.extract %133 from 16 : (i17) -> i1
    %135 = comb.extract %59 from 128 : (i266) -> i16
    %136 = comb.concat %false, %135 : i1, i16
    %137 = comb.concat %c0_i16, %134 : i16, i1
    %138 = comb.extract %142 from 0 : (i17) -> i16
    %139 = comb.concat %false, %138 : i1, i16
    %140 = comb.add %139, %136, %137 : i17
    %141 = sv.reg : !hw.inout<i17> 
    %142 = sv.read_inout %141 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %141, %140 : i17
    }(syncreset : posedge %reset) {
      sv.passign %141, %c0_i17 : i17
    }
    %143 = comb.extract %142 from 16 : (i17) -> i1
    %144 = comb.extract %59 from 144 : (i266) -> i16
    %145 = comb.concat %false, %144 : i1, i16
    %146 = comb.concat %c0_i16, %143 : i16, i1
    %147 = comb.extract %151 from 0 : (i17) -> i16
    %148 = comb.concat %false, %147 : i1, i16
    %149 = comb.add %148, %145, %146 : i17
    %150 = sv.reg : !hw.inout<i17> 
    %151 = sv.read_inout %150 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %150, %149 : i17
    }(syncreset : posedge %reset) {
      sv.passign %150, %c0_i17 : i17
    }
    %152 = comb.extract %151 from 16 : (i17) -> i1
    %153 = comb.extract %59 from 160 : (i266) -> i16
    %154 = comb.concat %false, %153 : i1, i16
    %155 = comb.concat %c0_i16, %152 : i16, i1
    %156 = comb.extract %160 from 0 : (i17) -> i16
    %157 = comb.concat %false, %156 : i1, i16
    %158 = comb.add %157, %154, %155 : i17
    %159 = sv.reg : !hw.inout<i17> 
    %160 = sv.read_inout %159 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %159, %158 : i17
    }(syncreset : posedge %reset) {
      sv.passign %159, %c0_i17 : i17
    }
    %161 = comb.extract %160 from 16 : (i17) -> i1
    %162 = comb.extract %59 from 176 : (i266) -> i16
    %163 = comb.concat %false, %162 : i1, i16
    %164 = comb.concat %c0_i16, %161 : i16, i1
    %165 = comb.extract %169 from 0 : (i17) -> i16
    %166 = comb.concat %false, %165 : i1, i16
    %167 = comb.add %166, %163, %164 : i17
    %168 = sv.reg : !hw.inout<i17> 
    %169 = sv.read_inout %168 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %168, %167 : i17
    }(syncreset : posedge %reset) {
      sv.passign %168, %c0_i17 : i17
    }
    %170 = comb.extract %169 from 16 : (i17) -> i1
    %171 = comb.extract %59 from 192 : (i266) -> i16
    %172 = comb.concat %false, %171 : i1, i16
    %173 = comb.concat %c0_i16, %170 : i16, i1
    %174 = comb.extract %178 from 0 : (i17) -> i16
    %175 = comb.concat %false, %174 : i1, i16
    %176 = comb.add %175, %172, %173 : i17
    %177 = sv.reg : !hw.inout<i17> 
    %178 = sv.read_inout %177 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %177, %176 : i17
    }(syncreset : posedge %reset) {
      sv.passign %177, %c0_i17 : i17
    }
    %179 = comb.extract %178 from 16 : (i17) -> i1
    %180 = comb.extract %59 from 208 : (i266) -> i16
    %181 = comb.concat %false, %180 : i1, i16
    %182 = comb.concat %c0_i16, %179 : i16, i1
    %183 = comb.extract %187 from 0 : (i17) -> i16
    %184 = comb.concat %false, %183 : i1, i16
    %185 = comb.add %184, %181, %182 : i17
    %186 = sv.reg : !hw.inout<i17> 
    %187 = sv.read_inout %186 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %186, %185 : i17
    }(syncreset : posedge %reset) {
      sv.passign %186, %c0_i17 : i17
    }
    %188 = comb.extract %187 from 16 : (i17) -> i1
    %189 = comb.extract %59 from 224 : (i266) -> i16
    %190 = comb.concat %false, %189 : i1, i16
    %191 = comb.concat %c0_i16, %188 : i16, i1
    %192 = comb.extract %196 from 0 : (i17) -> i16
    %193 = comb.concat %false, %192 : i1, i16
    %194 = comb.add %193, %190, %191 : i17
    %195 = sv.reg : !hw.inout<i17> 
    %196 = sv.read_inout %195 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %195, %194 : i17
    }(syncreset : posedge %reset) {
      sv.passign %195, %c0_i17 : i17
    }
    %197 = comb.extract %196 from 16 : (i17) -> i1
    %198 = comb.extract %59 from 240 : (i266) -> i16
    %199 = comb.concat %false, %198 : i1, i16
    %200 = comb.concat %c0_i16, %197 : i16, i1
    %201 = comb.extract %205 from 0 : (i17) -> i16
    %202 = comb.concat %false, %201 : i1, i16
    %203 = comb.add %202, %199, %200 : i17
    %204 = sv.reg : !hw.inout<i17> 
    %205 = sv.read_inout %204 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %204, %203 : i17
    }(syncreset : posedge %reset) {
      sv.passign %204, %c0_i17 : i17
    }
    %206 = comb.extract %205 from 16 : (i17) -> i1
    %207 = comb.extract %59 from 256 : (i266) -> i10
    %208 = comb.concat %false, %207 : i1, i10
    %209 = comb.concat %c0_i10, %206 : i10, i1
    %210 = comb.extract %214 from 0 : (i11) -> i10
    %211 = comb.concat %false, %210 : i1, i10
    %212 = comb.add %211, %208, %209 : i11
    %213 = sv.reg : !hw.inout<i11> 
    %214 = sv.read_inout %213 : !hw.inout<i11>
    sv.alwaysff(posedge %clk) {
      sv.passign %213, %212 : i11
    }(syncreset : posedge %reset) {
      sv.passign %213, %c0_i11 : i11
    }
    %215 = comb.concat %210, %201, %192, %183, %174, %165, %156, %147, %138, %129, %120, %111, %102, %93, %84, %75, %66 : i10, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16
    %216 = comb.concat %c0_i9, %206, %c0_i15, %197, %c0_i15, %188, %c0_i15, %179, %c0_i15, %170, %c0_i15, %161, %c0_i15, %152, %c0_i15, %143, %c0_i15, %134, %c0_i15, %125, %c0_i15, %116, %c0_i15, %107, %c0_i15, %98, %c0_i15, %89, %c0_i15, %80, %c0_i15, %71, %c0_i16 : i9, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i16
    %217 = comb.add %215, %216 : i266
    %218 = comb.icmp eq %217, %c0_i266 : i266
    %219 = comb.extract %217 from 265 : (i266) -> i1
    %220 = comb.xor %217, %c-1_i266 : i266
    %221 = comb.add %220, %c1_i266 : i266
    %222 = comb.mux %219, %221, %217 : i266
    %223 = comb.extract %222 from 10 : (i266) -> i256
    %224 = comb.icmp eq %223, %c0_i256 : i256
    %225 = comb.extract %222 from 0 : (i266) -> i10
    %226 = comb.concat %225, %c0_i245 : i10, i245
    %227 = comb.extract %222 from 11 : (i266) -> i255
    %228 = comb.mux %224, %226, %227 : i255
    %229 = comb.extract %228 from 127 : (i255) -> i128
    %230 = comb.icmp eq %229, %c0_i128 : i128
    %231 = comb.extract %228 from 0 : (i255) -> i127
    %232 = comb.extract %228 from 128 : (i255) -> i127
    %233 = comb.mux %230, %231, %232 : i127
    %234 = comb.extract %233 from 63 : (i127) -> i64
    %235 = comb.icmp eq %234, %c0_i64 : i64
    %236 = comb.extract %233 from 0 : (i127) -> i63
    %237 = comb.extract %233 from 64 : (i127) -> i63
    %238 = comb.mux %235, %236, %237 : i63
    %239 = comb.extract %238 from 31 : (i63) -> i32
    %240 = comb.icmp eq %239, %c0_i32 : i32
    %241 = comb.extract %238 from 0 : (i63) -> i31
    %242 = comb.extract %238 from 32 : (i63) -> i31
    %243 = comb.mux %240, %241, %242 : i31
    %244 = comb.extract %243 from 15 : (i31) -> i16
    %245 = comb.icmp eq %244, %c0_i16 : i16
    %246 = comb.extract %243 from 0 : (i31) -> i15
    %247 = comb.extract %243 from 16 : (i31) -> i15
    %248 = comb.mux %245, %246, %247 : i15
    %249 = comb.extract %248 from 7 : (i15) -> i8
    %250 = comb.icmp eq %249, %c0_i8 : i8
    %251 = comb.extract %248 from 0 : (i15) -> i7
    %252 = comb.extract %248 from 8 : (i15) -> i7
    %253 = comb.mux %250, %251, %252 : i7
    %254 = comb.extract %253 from 3 : (i7) -> i4
    %255 = comb.icmp eq %254, %c0_i4 : i4
    %256 = comb.extract %253 from 0 : (i7) -> i3
    %257 = comb.extract %253 from 4 : (i7) -> i3
    %258 = comb.mux %255, %256, %257 : i3
    %259 = comb.extract %258 from 1 : (i3) -> i2
    %260 = comb.icmp eq %259, %c0_i2 : i2
    %261 = comb.extract %258 from 0 : (i3) -> i1
    %262 = comb.extract %258 from 2 : (i3) -> i1
    %263 = comb.mux %260, %261, %262 : i1
    %264 = comb.xor %263, %true : i1
    %265 = comb.extract %222 from 0 : (i266) -> i9
    %266 = comb.concat %265, %c0_i256 : i9, i256
    %267 = comb.extract %222 from 0 : (i266) -> i265
    %268 = comb.mux %224, %266, %267 : i265
    %269 = comb.extract %268 from 0 : (i265) -> i137
    %270 = comb.concat %269, %c0_i128 : i137, i128
    %271 = comb.mux %230, %270, %268 : i265
    %272 = comb.extract %271 from 0 : (i265) -> i201
    %273 = comb.concat %272, %c0_i64 : i201, i64
    %274 = comb.mux %235, %273, %271 : i265
    %275 = comb.extract %274 from 0 : (i265) -> i233
    %276 = comb.concat %275, %c0_i32 : i233, i32
    %277 = comb.mux %240, %276, %274 : i265
    %278 = comb.extract %277 from 0 : (i265) -> i249
    %279 = comb.concat %278, %c0_i16 : i249, i16
    %280 = comb.mux %245, %279, %277 : i265
    %281 = comb.extract %280 from 0 : (i265) -> i257
    %282 = comb.concat %281, %c0_i8 : i257, i8
    %283 = comb.mux %250, %282, %280 : i265
    %284 = comb.extract %283 from 0 : (i265) -> i261
    %285 = comb.concat %284, %c0_i4 : i261, i4
    %286 = comb.mux %255, %285, %283 : i265
    %287 = comb.extract %286 from 0 : (i265) -> i263
    %288 = comb.concat %287, %c0_i2 : i263, i2
    %289 = comb.mux %260, %288, %286 : i265
    %290 = comb.extract %289 from 0 : (i265) -> i264
    %291 = comb.concat %290, %false : i264, i1
    %292 = comb.mux %264, %291, %289 : i265
    %293 = comb.extract %292 from 0 : (i265) -> i256
    %294 = comb.icmp ne %293, %c0_i256 : i256
    %295 = comb.concat %c0_i2, %224, %230, %235, %240, %245, %250, %255, %260, %264 : i2, i1, i1, i1, i1, i1, i1, i1, i1, i1
    %296 = comb.sub %c132_i11, %295 : i11
    %297 = comb.extract %292 from 258 : (i265) -> i7
    %298 = comb.extract %292 from 257 : (i265) -> i1
    %299 = comb.extract %292 from 256 : (i265) -> i1
    %300 = comb.extract %292 from 258 : (i265) -> i1
    %301 = comb.or %299, %294, %300 : i1
    %302 = comb.and %298, %301 : i1
    %303 = comb.concat %c0_i8, %302 : i8, i1
    %304 = comb.concat %c1_i2, %297 : i2, i7
    %305 = comb.add %304, %303 : i9
    %306 = comb.extract %305 from 8 : (i9) -> i1
    %307 = comb.extract %305 from 1 : (i9) -> i7
    %308 = comb.extract %305 from 0 : (i9) -> i7
    %309 = comb.mux %306, %307, %308 : i7
    %310 = comb.concat %c0_i10, %306 : i10, i1
    %311 = comb.add %296, %310, %c127_i11 : i11
    %312 = comb.icmp slt %311, %c1_i11 : i11
    %313 = comb.icmp sgt %311, %c254_i11 : i11
    %314 = comb.extract %311 from 0 : (i11) -> i8
    %315 = comb.or %312, %218 : i1
    %316 = comb.mux %315, %c0_i8, %314 : i8
    %317 = comb.mux %313, %c-1_i8, %316 : i8
    %318 = comb.or %312, %218, %313 : i1
    %319 = comb.mux %318, %c0_i7, %309 : i7
    %320 = comb.concat %219, %317, %319 : i1, i8, i7
    %321 = comb.mux %62, %c32704_i16, %320 : i16
    hw.output %321 : i16
  }
}

