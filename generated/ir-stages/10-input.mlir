module {
  func.func @fpmult_loop_muladd_s3fdp(
      %clk: i1 {hw.name = "clk"},
      %reset: i1 {hw.name = "reset"},
      %a: memref<2xbf16> {hw.name = "a"},
      %b: memref<2xbf16> {hw.name = "b"},
      %c: memref<2xbf16> {hw.name = "c"})
      -> (bf16 {hw.name = "r"}) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index

    scf.for %k = %c0 to %c2 step %c1 {
      %x = memref.load %a[%k] : memref<2xbf16>
      %y = memref.load %b[%k] : memref<2xbf16>
      %acc = memref.load %c[%c0] : memref<2xbf16>
      %m = arith.mulf %x, %y : bf16
      %s = arith.addf %acc, %m : bf16
      memref.store %s, %c[%c0] : memref<2xbf16>
    }

    %r = memref.load %c[%c0] : memref<2xbf16>
    func.return %r : bf16
  }
}
