module {
  func.func @fpmult_loop_muladd_s3fdp(
      %clk: i1 {hw.name = "clk"},
      %reset: i1 {hw.name = "reset"},
      %a: memref<2xf32> {hw.name = "a"},
      %b: memref<2xf32> {hw.name = "b"},
      %c: memref<2xf32> {hw.name = "c"})
      -> (f32 {hw.name = "r"}) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index

    scf.for %k = %c0 to %c2 step %c1 {
      %x = memref.load %a[%k] : memref<2xf32>
      %y = memref.load %b[%k] : memref<2xf32>
      %acc = memref.load %c[%c0] : memref<2xf32>
      %m = arith.mulf %x, %y : f32
      %s = arith.addf %acc, %m : f32
      memref.store %s, %c[%c0] : memref<2xf32>
    }

    %r = memref.load %c[%c0] : memref<2xf32>
    func.return %r : f32
  }
}
