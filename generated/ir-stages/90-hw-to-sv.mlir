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
    %c0_i257 = hw.constant 0 : i257
    %c0_i253 = hw.constant 0 : i253
    %c32704_i16 = hw.constant 32704 : i16
    %c1_i11 = hw.constant 1 : i11
    %c1_i2 = hw.constant 1 : i2
    %c-120_i9 = hw.constant -120 : i9
    %c254_i11 = hw.constant 254 : i11
    %c0_i7 = hw.constant 0 : i7
    %c0_i10 = hw.constant 0 : i10
    %c127_i11 = hw.constant 127 : i11
    %c124_i11 = hw.constant 124 : i11
    %c0_i248 = hw.constant 0 : i248
    %c1_i258 = hw.constant 1 : i258
    %c-1_i258 = hw.constant -1 : i258
    %c0_i15 = hw.constant 0 : i15
    %c0_i3 = hw.constant 0 : i3
    %c0_i17 = hw.constant 0 : i17
    %c0_i258 = hw.constant 0 : i258
    %c253_i9 = hw.constant 253 : i9
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
    %24 = comb.concat %false, %21, %c0_i256 : i1, i16, i256
    %25 = comb.concat %c0_i257, %21 : i257, i16
    %26 = comb.mux %23, %24, %25 : i273
    %27 = comb.extract %22 from 7 : (i9) -> i1
    %28 = comb.extract %26 from 0 : (i273) -> i145
    %29 = comb.concat %28, %c0_i128 : i145, i128
    %30 = comb.mux %27, %29, %26 : i273
    %31 = comb.extract %22 from 6 : (i9) -> i1
    %32 = comb.extract %30 from 0 : (i273) -> i209
    %33 = comb.concat %32, %c0_i64 : i209, i64
    %34 = comb.mux %31, %33, %30 : i273
    %35 = comb.extract %22 from 5 : (i9) -> i1
    %36 = comb.extract %34 from 0 : (i273) -> i241
    %37 = comb.concat %36, %c0_i32 : i241, i32
    %38 = comb.mux %35, %37, %34 : i273
    %39 = comb.extract %22 from 4 : (i9) -> i1
    %40 = comb.extract %38 from 0 : (i273) -> i257
    %41 = comb.concat %40, %c0_i16 : i257, i16
    %42 = comb.mux %39, %41, %38 : i273
    %43 = comb.extract %22 from 3 : (i9) -> i1
    %44 = comb.extract %42 from 0 : (i273) -> i265
    %45 = comb.extract %42 from 8 : (i273) -> i265
    %46 = comb.mux %43, %44, %45 : i265
    %47 = comb.extract %22 from 2 : (i9) -> i1
    %48 = comb.extract %46 from 0 : (i265) -> i261
    %49 = comb.extract %46 from 4 : (i265) -> i261
    %50 = comb.mux %47, %48, %49 : i261
    %51 = comb.extract %22 from 1 : (i9) -> i1
    %52 = comb.extract %50 from 0 : (i261) -> i259
    %53 = comb.extract %50 from 2 : (i261) -> i259
    %54 = comb.mux %51, %52, %53 : i259
    %55 = comb.extract %22 from 0 : (i9) -> i1
    %56 = comb.extract %54 from 0 : (i259) -> i258
    %57 = comb.extract %54 from 1 : (i259) -> i258
    %58 = comb.mux %55, %56, %57 : i258
    %59 = comb.icmp sgt %22, %c253_i9 : i9
    %60 = comb.mux %23, %c0_i258, %58 : i258
    %61 = comb.or %59, %4, %11, %63 : i1
    %62 = sv.reg : !hw.inout<i1> 
    %63 = sv.read_inout %62 : !hw.inout<i1>
    sv.alwaysff(posedge %clk) {
      sv.passign %62, %61 : i1
    }(syncreset : posedge %reset) {
      sv.passign %62, %false : i1
    }
    %64 = comb.extract %60 from 0 : (i258) -> i16
    %65 = comb.concat %false, %64 : i1, i16
    %66 = comb.concat %c0_i16, %14 : i16, i1
    %67 = comb.extract %71 from 0 : (i17) -> i16
    %68 = comb.concat %false, %67 : i1, i16
    %69 = comb.add %68, %65, %66 : i17
    %70 = sv.reg : !hw.inout<i17> 
    %71 = sv.read_inout %70 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %70, %69 : i17
    }(syncreset : posedge %reset) {
      sv.passign %70, %c0_i17 : i17
    }
    %72 = comb.extract %71 from 16 : (i17) -> i1
    %73 = comb.extract %60 from 16 : (i258) -> i16
    %74 = comb.concat %false, %73 : i1, i16
    %75 = comb.concat %c0_i16, %72 : i16, i1
    %76 = comb.extract %80 from 0 : (i17) -> i16
    %77 = comb.concat %false, %76 : i1, i16
    %78 = comb.add %77, %74, %75 : i17
    %79 = sv.reg : !hw.inout<i17> 
    %80 = sv.read_inout %79 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %79, %78 : i17
    }(syncreset : posedge %reset) {
      sv.passign %79, %c0_i17 : i17
    }
    %81 = comb.extract %80 from 16 : (i17) -> i1
    %82 = comb.extract %60 from 32 : (i258) -> i16
    %83 = comb.concat %false, %82 : i1, i16
    %84 = comb.concat %c0_i16, %81 : i16, i1
    %85 = comb.extract %89 from 0 : (i17) -> i16
    %86 = comb.concat %false, %85 : i1, i16
    %87 = comb.add %86, %83, %84 : i17
    %88 = sv.reg : !hw.inout<i17> 
    %89 = sv.read_inout %88 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %88, %87 : i17
    }(syncreset : posedge %reset) {
      sv.passign %88, %c0_i17 : i17
    }
    %90 = comb.extract %89 from 16 : (i17) -> i1
    %91 = comb.extract %60 from 48 : (i258) -> i16
    %92 = comb.concat %false, %91 : i1, i16
    %93 = comb.concat %c0_i16, %90 : i16, i1
    %94 = comb.extract %98 from 0 : (i17) -> i16
    %95 = comb.concat %false, %94 : i1, i16
    %96 = comb.add %95, %92, %93 : i17
    %97 = sv.reg : !hw.inout<i17> 
    %98 = sv.read_inout %97 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %97, %96 : i17
    }(syncreset : posedge %reset) {
      sv.passign %97, %c0_i17 : i17
    }
    %99 = comb.extract %98 from 16 : (i17) -> i1
    %100 = comb.extract %60 from 64 : (i258) -> i16
    %101 = comb.concat %false, %100 : i1, i16
    %102 = comb.concat %c0_i16, %99 : i16, i1
    %103 = comb.extract %107 from 0 : (i17) -> i16
    %104 = comb.concat %false, %103 : i1, i16
    %105 = comb.add %104, %101, %102 : i17
    %106 = sv.reg : !hw.inout<i17> 
    %107 = sv.read_inout %106 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %106, %105 : i17
    }(syncreset : posedge %reset) {
      sv.passign %106, %c0_i17 : i17
    }
    %108 = comb.extract %107 from 16 : (i17) -> i1
    %109 = comb.extract %60 from 80 : (i258) -> i16
    %110 = comb.concat %false, %109 : i1, i16
    %111 = comb.concat %c0_i16, %108 : i16, i1
    %112 = comb.extract %116 from 0 : (i17) -> i16
    %113 = comb.concat %false, %112 : i1, i16
    %114 = comb.add %113, %110, %111 : i17
    %115 = sv.reg : !hw.inout<i17> 
    %116 = sv.read_inout %115 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %115, %114 : i17
    }(syncreset : posedge %reset) {
      sv.passign %115, %c0_i17 : i17
    }
    %117 = comb.extract %116 from 16 : (i17) -> i1
    %118 = comb.extract %60 from 96 : (i258) -> i16
    %119 = comb.concat %false, %118 : i1, i16
    %120 = comb.concat %c0_i16, %117 : i16, i1
    %121 = comb.extract %125 from 0 : (i17) -> i16
    %122 = comb.concat %false, %121 : i1, i16
    %123 = comb.add %122, %119, %120 : i17
    %124 = sv.reg : !hw.inout<i17> 
    %125 = sv.read_inout %124 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %124, %123 : i17
    }(syncreset : posedge %reset) {
      sv.passign %124, %c0_i17 : i17
    }
    %126 = comb.extract %125 from 16 : (i17) -> i1
    %127 = comb.extract %60 from 112 : (i258) -> i16
    %128 = comb.concat %false, %127 : i1, i16
    %129 = comb.concat %c0_i16, %126 : i16, i1
    %130 = comb.extract %134 from 0 : (i17) -> i16
    %131 = comb.concat %false, %130 : i1, i16
    %132 = comb.add %131, %128, %129 : i17
    %133 = sv.reg : !hw.inout<i17> 
    %134 = sv.read_inout %133 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %133, %132 : i17
    }(syncreset : posedge %reset) {
      sv.passign %133, %c0_i17 : i17
    }
    %135 = comb.extract %134 from 16 : (i17) -> i1
    %136 = comb.extract %60 from 128 : (i258) -> i16
    %137 = comb.concat %false, %136 : i1, i16
    %138 = comb.concat %c0_i16, %135 : i16, i1
    %139 = comb.extract %143 from 0 : (i17) -> i16
    %140 = comb.concat %false, %139 : i1, i16
    %141 = comb.add %140, %137, %138 : i17
    %142 = sv.reg : !hw.inout<i17> 
    %143 = sv.read_inout %142 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %142, %141 : i17
    }(syncreset : posedge %reset) {
      sv.passign %142, %c0_i17 : i17
    }
    %144 = comb.extract %143 from 16 : (i17) -> i1
    %145 = comb.extract %60 from 144 : (i258) -> i16
    %146 = comb.concat %false, %145 : i1, i16
    %147 = comb.concat %c0_i16, %144 : i16, i1
    %148 = comb.extract %152 from 0 : (i17) -> i16
    %149 = comb.concat %false, %148 : i1, i16
    %150 = comb.add %149, %146, %147 : i17
    %151 = sv.reg : !hw.inout<i17> 
    %152 = sv.read_inout %151 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %151, %150 : i17
    }(syncreset : posedge %reset) {
      sv.passign %151, %c0_i17 : i17
    }
    %153 = comb.extract %152 from 16 : (i17) -> i1
    %154 = comb.extract %60 from 160 : (i258) -> i16
    %155 = comb.concat %false, %154 : i1, i16
    %156 = comb.concat %c0_i16, %153 : i16, i1
    %157 = comb.extract %161 from 0 : (i17) -> i16
    %158 = comb.concat %false, %157 : i1, i16
    %159 = comb.add %158, %155, %156 : i17
    %160 = sv.reg : !hw.inout<i17> 
    %161 = sv.read_inout %160 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %160, %159 : i17
    }(syncreset : posedge %reset) {
      sv.passign %160, %c0_i17 : i17
    }
    %162 = comb.extract %161 from 16 : (i17) -> i1
    %163 = comb.extract %60 from 176 : (i258) -> i16
    %164 = comb.concat %false, %163 : i1, i16
    %165 = comb.concat %c0_i16, %162 : i16, i1
    %166 = comb.extract %170 from 0 : (i17) -> i16
    %167 = comb.concat %false, %166 : i1, i16
    %168 = comb.add %167, %164, %165 : i17
    %169 = sv.reg : !hw.inout<i17> 
    %170 = sv.read_inout %169 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %169, %168 : i17
    }(syncreset : posedge %reset) {
      sv.passign %169, %c0_i17 : i17
    }
    %171 = comb.extract %170 from 16 : (i17) -> i1
    %172 = comb.extract %60 from 192 : (i258) -> i16
    %173 = comb.concat %false, %172 : i1, i16
    %174 = comb.concat %c0_i16, %171 : i16, i1
    %175 = comb.extract %179 from 0 : (i17) -> i16
    %176 = comb.concat %false, %175 : i1, i16
    %177 = comb.add %176, %173, %174 : i17
    %178 = sv.reg : !hw.inout<i17> 
    %179 = sv.read_inout %178 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %178, %177 : i17
    }(syncreset : posedge %reset) {
      sv.passign %178, %c0_i17 : i17
    }
    %180 = comb.extract %179 from 16 : (i17) -> i1
    %181 = comb.extract %60 from 208 : (i258) -> i16
    %182 = comb.concat %false, %181 : i1, i16
    %183 = comb.concat %c0_i16, %180 : i16, i1
    %184 = comb.extract %188 from 0 : (i17) -> i16
    %185 = comb.concat %false, %184 : i1, i16
    %186 = comb.add %185, %182, %183 : i17
    %187 = sv.reg : !hw.inout<i17> 
    %188 = sv.read_inout %187 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %187, %186 : i17
    }(syncreset : posedge %reset) {
      sv.passign %187, %c0_i17 : i17
    }
    %189 = comb.extract %188 from 16 : (i17) -> i1
    %190 = comb.extract %60 from 224 : (i258) -> i16
    %191 = comb.concat %false, %190 : i1, i16
    %192 = comb.concat %c0_i16, %189 : i16, i1
    %193 = comb.extract %197 from 0 : (i17) -> i16
    %194 = comb.concat %false, %193 : i1, i16
    %195 = comb.add %194, %191, %192 : i17
    %196 = sv.reg : !hw.inout<i17> 
    %197 = sv.read_inout %196 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %196, %195 : i17
    }(syncreset : posedge %reset) {
      sv.passign %196, %c0_i17 : i17
    }
    %198 = comb.extract %197 from 16 : (i17) -> i1
    %199 = comb.extract %60 from 240 : (i258) -> i16
    %200 = comb.concat %false, %199 : i1, i16
    %201 = comb.concat %c0_i16, %198 : i16, i1
    %202 = comb.extract %206 from 0 : (i17) -> i16
    %203 = comb.concat %false, %202 : i1, i16
    %204 = comb.add %203, %200, %201 : i17
    %205 = sv.reg : !hw.inout<i17> 
    %206 = sv.read_inout %205 : !hw.inout<i17>
    sv.alwaysff(posedge %clk) {
      sv.passign %205, %204 : i17
    }(syncreset : posedge %reset) {
      sv.passign %205, %c0_i17 : i17
    }
    %207 = comb.extract %206 from 16 : (i17) -> i1
    %208 = comb.extract %60 from 256 : (i258) -> i2
    %209 = comb.concat %false, %208 : i1, i2
    %210 = comb.concat %c0_i2, %207 : i2, i1
    %211 = comb.extract %215 from 0 : (i3) -> i2
    %212 = comb.concat %false, %211 : i1, i2
    %213 = comb.add %212, %209, %210 : i3
    %214 = sv.reg : !hw.inout<i3> 
    %215 = sv.read_inout %214 : !hw.inout<i3>
    sv.alwaysff(posedge %clk) {
      sv.passign %214, %213 : i3
    }(syncreset : posedge %reset) {
      sv.passign %214, %c0_i3 : i3
    }
    %216 = comb.concat %211, %202, %193, %184, %175, %166, %157, %148, %139, %130, %121, %112, %103, %94, %85, %76, %67 : i2, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16
    %217 = comb.concat %false, %207, %c0_i15, %198, %c0_i15, %189, %c0_i15, %180, %c0_i15, %171, %c0_i15, %162, %c0_i15, %153, %c0_i15, %144, %c0_i15, %135, %c0_i15, %126, %c0_i15, %117, %c0_i15, %108, %c0_i15, %99, %c0_i15, %90, %c0_i15, %81, %c0_i15, %72, %c0_i16 : i1, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i15, i1, i16
    %218 = comb.add %216, %217 : i258
    %219 = comb.icmp eq %218, %c0_i258 : i258
    %220 = comb.extract %218 from 257 : (i258) -> i1
    %221 = comb.xor %218, %c-1_i258 : i258
    %222 = comb.add %221, %c1_i258 : i258
    %223 = comb.mux %220, %222, %218 : i258
    %224 = comb.extract %223 from 2 : (i258) -> i256
    %225 = comb.icmp eq %224, %c0_i256 : i256
    %226 = comb.extract %223 from 0 : (i258) -> i2
    %227 = comb.concat %226, %c0_i253 : i2, i253
    %228 = comb.extract %223 from 3 : (i258) -> i255
    %229 = comb.mux %225, %227, %228 : i255
    %230 = comb.extract %229 from 127 : (i255) -> i128
    %231 = comb.icmp eq %230, %c0_i128 : i128
    %232 = comb.extract %229 from 0 : (i255) -> i127
    %233 = comb.extract %229 from 128 : (i255) -> i127
    %234 = comb.mux %231, %232, %233 : i127
    %235 = comb.extract %234 from 63 : (i127) -> i64
    %236 = comb.icmp eq %235, %c0_i64 : i64
    %237 = comb.extract %234 from 0 : (i127) -> i63
    %238 = comb.extract %234 from 64 : (i127) -> i63
    %239 = comb.mux %236, %237, %238 : i63
    %240 = comb.extract %239 from 31 : (i63) -> i32
    %241 = comb.icmp eq %240, %c0_i32 : i32
    %242 = comb.extract %239 from 0 : (i63) -> i31
    %243 = comb.extract %239 from 32 : (i63) -> i31
    %244 = comb.mux %241, %242, %243 : i31
    %245 = comb.extract %244 from 15 : (i31) -> i16
    %246 = comb.icmp eq %245, %c0_i16 : i16
    %247 = comb.extract %244 from 0 : (i31) -> i15
    %248 = comb.extract %244 from 16 : (i31) -> i15
    %249 = comb.mux %246, %247, %248 : i15
    %250 = comb.extract %249 from 7 : (i15) -> i8
    %251 = comb.icmp eq %250, %c0_i8 : i8
    %252 = comb.extract %249 from 0 : (i15) -> i7
    %253 = comb.extract %249 from 8 : (i15) -> i7
    %254 = comb.mux %251, %252, %253 : i7
    %255 = comb.extract %254 from 3 : (i7) -> i4
    %256 = comb.icmp eq %255, %c0_i4 : i4
    %257 = comb.extract %254 from 0 : (i7) -> i3
    %258 = comb.extract %254 from 4 : (i7) -> i3
    %259 = comb.mux %256, %257, %258 : i3
    %260 = comb.extract %259 from 1 : (i3) -> i2
    %261 = comb.icmp eq %260, %c0_i2 : i2
    %262 = comb.extract %259 from 0 : (i3) -> i1
    %263 = comb.extract %259 from 2 : (i3) -> i1
    %264 = comb.mux %261, %262, %263 : i1
    %265 = comb.xor %264, %true : i1
    %266 = comb.extract %223 from 0 : (i258) -> i1
    %267 = comb.concat %266, %c0_i256 : i1, i256
    %268 = comb.extract %223 from 0 : (i258) -> i257
    %269 = comb.mux %225, %267, %268 : i257
    %270 = comb.extract %269 from 0 : (i257) -> i129
    %271 = comb.concat %270, %c0_i128 : i129, i128
    %272 = comb.mux %231, %271, %269 : i257
    %273 = comb.extract %272 from 0 : (i257) -> i193
    %274 = comb.concat %273, %c0_i64 : i193, i64
    %275 = comb.mux %236, %274, %272 : i257
    %276 = comb.extract %275 from 0 : (i257) -> i225
    %277 = comb.concat %276, %c0_i32 : i225, i32
    %278 = comb.mux %241, %277, %275 : i257
    %279 = comb.extract %278 from 0 : (i257) -> i241
    %280 = comb.concat %279, %c0_i16 : i241, i16
    %281 = comb.mux %246, %280, %278 : i257
    %282 = comb.extract %281 from 0 : (i257) -> i249
    %283 = comb.concat %282, %c0_i8 : i249, i8
    %284 = comb.mux %251, %283, %281 : i257
    %285 = comb.extract %284 from 0 : (i257) -> i253
    %286 = comb.concat %285, %c0_i4 : i253, i4
    %287 = comb.mux %256, %286, %284 : i257
    %288 = comb.extract %287 from 0 : (i257) -> i255
    %289 = comb.concat %288, %c0_i2 : i255, i2
    %290 = comb.mux %261, %289, %287 : i257
    %291 = comb.extract %290 from 0 : (i257) -> i256
    %292 = comb.concat %291, %false : i256, i1
    %293 = comb.mux %265, %292, %290 : i257
    %294 = comb.extract %293 from 0 : (i257) -> i248
    %295 = comb.icmp ne %294, %c0_i248 : i248
    %296 = comb.concat %c0_i2, %225, %231, %236, %241, %246, %251, %256, %261, %265 : i2, i1, i1, i1, i1, i1, i1, i1, i1, i1
    %297 = comb.sub %c124_i11, %296 : i11
    %298 = comb.extract %293 from 250 : (i257) -> i7
    %299 = comb.extract %293 from 249 : (i257) -> i1
    %300 = comb.extract %293 from 248 : (i257) -> i1
    %301 = comb.extract %293 from 250 : (i257) -> i1
    %302 = comb.or %300, %295, %301 : i1
    %303 = comb.and %299, %302 : i1
    %304 = comb.concat %c0_i8, %303 : i8, i1
    %305 = comb.concat %c1_i2, %298 : i2, i7
    %306 = comb.add %305, %304 : i9
    %307 = comb.extract %306 from 8 : (i9) -> i1
    %308 = comb.extract %306 from 1 : (i9) -> i7
    %309 = comb.extract %306 from 0 : (i9) -> i7
    %310 = comb.mux %307, %308, %309 : i7
    %311 = comb.concat %c0_i10, %307 : i10, i1
    %312 = comb.add %297, %311, %c127_i11 : i11
    %313 = comb.icmp slt %312, %c1_i11 : i11
    %314 = comb.icmp sgt %312, %c254_i11 : i11
    %315 = comb.extract %312 from 0 : (i11) -> i8
    %316 = comb.or %313, %219 : i1
    %317 = comb.mux %316, %c0_i8, %315 : i8
    %318 = comb.mux %314, %c-1_i8, %317 : i8
    %319 = comb.or %313, %219, %314 : i1
    %320 = comb.mux %319, %c0_i7, %310 : i7
    %321 = comb.concat %220, %318, %320 : i1, i8, i7
    %322 = comb.mux %63, %c32704_i16, %321 : i16
    hw.output %322 : i16
  }
}

