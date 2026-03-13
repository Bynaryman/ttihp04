module {
  func.func @fpmult_loop_muladd_s3fdp(%arg0: i1 {hw.name = "clk"}, %arg1: i1 {hw.name = "reset"}, %arg2: memref<2xf32> {hw.name = "a"}, %arg3: memref<2xf32> {hw.name = "b"}, %arg4: memref<2xf32> {hw.name = "c"}) -> (f32 {hw.name = "r"}) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    scf.for %arg5 = %c0 to %c2 step %c1 {
      %1 = memref.load %arg2[%arg5] : memref<2xf32>
      %2 = memref.load %arg3[%arg5] : memref<2xf32>
      %3 = memref.load %arg4[%c0] : memref<2xf32>
      %4 = arith.mulf %1, %2 : f32
      %5 = arith.addf %3, %4 : f32
      memref.store %5, %arg4[%c0] : memref<2xf32>
    }
    %0 = memref.load %arg4[%c0] : memref<2xf32>
    return %0 : f32
  }
}

