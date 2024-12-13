import gemo
import gleam/bool
import gleam/string
import gleeunit
import gleeunit/should
import tempo/duration

pub fn main() {
  gleeunit.main()
}

fn is_function(func: a, args: String) {
  func
  |> string.inspect
  |> should.equal("//fn(" <> args <> ") { ... }")
}

pub fn stable_api_test() {
  gemo.cache_count |> is_function("")
  gemo.cache_density |> is_function("")
  gemo.cache_size |> is_function("")
  gemo.memoize0 |> is_function("a, b")
  gemo.memoize1 |> is_function("a, b, c")
  gemo.memoize2 |> is_function("a, b, c, d")
  gemo.memoize3 |> is_function("a, b, c, d, e")
  gemo.memoize4 |> is_function("a, b, c, d, e, f")
  gemo.memoize5 |> is_function("a, b, c, d, e, f, g")
  gemo.memoize6 |> is_function("a, b, c, d, e, f, g, h")
  gemo.memoize7 |> is_function("a, b, c, d, e, f, g, h, i")
  gemo.memoize8 |> is_function("a, b, c, d, e, f, g, h, i, j")
  gemo.memoize9 |> is_function("a, b, c, d, e, f, g, h, i, j, k")
  gemo.memoize10 |> is_function("a, b, c, d, e, f, g, h, i, j, k, l")
}

pub fn initial_cache_count_test() {
  gemo.reset_cache()
  gemo.cache_count()
  |> should.equal(0)
}

pub fn initial_cache_size_test() {
  gemo.reset_cache()
  gemo.cache_size()
  |> should.equal(0)
}

pub fn initial_cache_density_test() {
  gemo.reset_cache()
  gemo.cache_density()
  |> should.equal(0.0)
}

pub fn reset_cache_test() {
  gemo.reset_cache()
  memo0()
  initial_cache_count_test()
  initial_cache_size_test()
  initial_cache_density_test()
}

fn memo0() {
  use <- gemo.memoize0(memo0)
  123
}

fn memo1(a) {
  use <- gemo.memoize1(memo1, a)
  a + 123
}

pub fn memoize_test() {
  // memoize0
  memo0()
  gemo.cache_count()
  |> should.equal(1)
  let size = gemo.cache_size()
  size |> should.not_equal(0)
  let density = gemo.cache_density()
  density |> should.not_equal(0.0)

  memo0()
  gemo.cache_count() |> should.equal(1)
  gemo.cache_size() |> should.equal(size)
  gemo.cache_density() |> should.equal(density)

  // memoize1
  memo1(1)
  gemo.cache_count()
  |> should.equal(2)
  let sizea = gemo.cache_size()
  { sizea > size } |> should.equal(True)
  let densitya = gemo.cache_density()
  densitya |> should.not_equal(density)

  memo1(1)
  gemo.cache_count() |> should.equal(2)
  gemo.cache_size() |> should.equal(sizea)
  gemo.cache_density() |> should.equal(densitya)

  memo1(2)
  gemo.cache_count()
  |> should.equal(3)
  let size = gemo.cache_size()
  { size > sizea } |> should.equal(True)
  let density = gemo.cache_density()
  density |> should.not_equal(densitya)

  memo1(2)
  gemo.cache_count() |> should.equal(3)
  gemo.cache_size() |> should.equal(size)
  gemo.cache_density() |> should.equal(density)
}

fn fib(n) {
  use <- gemo.memoize1(fib, n)
  use <- bool.guard(n <= 1, n)
  fib(n - 1) + fib(n - 2)
}

pub fn fib11_test() {
  fib(0) |> should.equal(0)
  fib(1) |> should.equal(1)
  fib(2) |> should.equal(1)
  fib(3) |> should.equal(2)
  fib(4) |> should.equal(3)
  fib(5) |> should.equal(5)
  fib(6) |> should.equal(8)
  fib(7) |> should.equal(13)
  fib(8) |> should.equal(21)
  fib(9) |> should.equal(34)
  fib(10) |> should.equal(55)
  fib(11) |> should.equal(89)
}

pub fn fib12_test() {
  fib(0) |> should.equal(0)
  fib(1) |> should.equal(1)
  fib(2) |> should.equal(1)
  fib(3) |> should.equal(2)
  fib(4) |> should.equal(3)
  fib(5) |> should.equal(5)
  fib(6) |> should.equal(8)
  fib(7) |> should.equal(13)
  fib(8) |> should.equal(21)
  fib(9) |> should.equal(34)
  fib(10) |> should.equal(55)
  fib(11) |> should.equal(89)
  fib(12) |> should.equal(144)
}

pub fn fib39_test() {
  let start = duration.start_monotonic()
  fib(39) |> should.equal(63_245_986)
  { { duration.stop_monotonic(start) |> duration.as_milliseconds } < 1000 }
  |> should.equal(True)
}
