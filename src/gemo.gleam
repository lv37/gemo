import gleam/int
import gleam/result
import lamb

const table_name = "@@#!*(#@&!_memoization_cache"

@external(javascript, "./gemo_ffi.mjs", "memoize")
fn do_memoize(func: a, args: b, cb: fn() -> c) -> c {
  let table = get_table()

  case lamb.lookup(table, #(func, args)) {
    [] -> {
      let out = cb()
      lamb.insert(table, #(func, args), out)
      out
    }
    [cache, ..] -> cache
  }
}

@external(javascript, "./gemo_ffi.mjs", "get_cache")
fn get_table() -> lamb.Table(a, b) {
  table_name
  |> lamb.from_name
  |> result.lazy_unwrap(fn() {
    let assert Ok(table) = lamb.create(table_name, lamb.Private, lamb.Set, True)
    table
  })
}

@external(javascript, "./gemo_ffi.mjs", "reset_cache")
pub fn reset_cache() -> Nil {
  get_table()
  |> lamb.delete
}

@external(erlang, "gemo_ffi", "table_size")
fn table_size(table: a) -> Int

/// Get the cache size in bytes.
@external(javascript, "./gemo_ffi.mjs", "cache_size")
pub fn cache_size() -> Int {
  get_table().reference
  |> table_size
}

@external(erlang, "gemo_ffi", "table_count")
fn table_count(table: a) -> Int

/// Get the amount of cached data.
@external(javascript, "./gemo_ffi.mjs", "cache_count")
pub fn cache_count() -> Int {
  get_table().reference
  |> table_count
}

/// cache_size / cache_count
pub fn cache_density() -> Float {
  { cache_size() |> int.to_float() } /. { cache_count() |> int.to_float() }
}

/// Takes the parent function as a key and executes the callback if its output is not already cached.
/// This should be called with a use expression at the top of the function
///
/// ## Example:
/// ```gleam
/// fn complex_task() {
///   use <- glemo.memoize0(complex_task)
///   "./huge_file.csv"
///   |> read_file
///   |> hash
/// }
pub fn memoize0(func: fn() -> a, cb: fn() -> a) -> a {
  do_memoize(func, #(), cb)
}

/// Takes the parent function and its args as a key and executes the callback if its output is not already cached.
/// This should be called with a use expression at the top of the function
///
/// ## Example:
/// ```gleam
/// fn fib(n) {
///   use <- glemo.memoize1(fib, n)
///   use <- bool.guard(n <= 1, n)
///   fib(n - 1) + fib(n - 2)
/// }
pub fn memoize1(func: fn(b) -> a, arg1: b, cb: fn() -> a) -> a {
  do_memoize(func, #(arg1), cb)
}

/// Same as memoize1 but with 2 args.
pub fn memoize2(func: fn(b, c) -> a, arg1: b, arg2: c, cb: fn() -> a) -> a {
  do_memoize(func, #(arg1, arg2), cb)
}

/// Same as memoize1 but with 3 args.
pub fn memoize3(
  func: fn(b, c, d) -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  cb: fn() -> a,
) -> a {
  do_memoize(func, #(arg1, arg2, arg3), cb)
}

/// Same as memoize1 but with 4 args.
pub fn memoize4(
  func: fn(b, c, d, e) -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  arg4: e,
  cb: fn() -> a,
) -> a {
  do_memoize(func, #(arg1, arg2, arg3, arg4), cb)
}

/// Same as memoize1 but with 5 args.
pub fn memoize5(
  func: fn(b, c, d, e, f) -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  arg4: e,
  arg5: f,
  cb: fn() -> a,
) -> a {
  do_memoize(func, #(arg1, arg2, arg3, arg4, arg5), cb)
}

/// Same as memoize1 but with 6 args.
pub fn memoize6(
  func: fn(b, c, d, e, f, g) -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  arg4: e,
  arg5: f,
  arg6: g,
  cb: fn() -> a,
) -> a {
  do_memoize(func, #(arg1, arg2, arg3, arg4, arg5, arg6), cb)
}

/// Same as memoize1 but with 7 args.
pub fn memoize7(
  func: fn(b, c, d, e, f, g, h) -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  arg4: e,
  arg5: f,
  arg6: g,
  arg7: h,
  cb: fn() -> a,
) -> a {
  do_memoize(func, #(arg1, arg2, arg3, arg4, arg5, arg6, arg7), cb)
}

/// Same as memoize1 but with 8 args.
pub fn memoize8(
  func: fn(b, c, d, e, f, g, h, i) -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  arg4: e,
  arg5: f,
  arg6: g,
  arg7: h,
  arg8: i,
  cb: fn() -> a,
) -> a {
  do_memoize(func, #(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8), cb)
}

/// Same as memoize1 but with 9 args.
pub fn memoize9(
  func: fn(b, c, d, e, f, g, h, i, j) -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  arg4: e,
  arg5: f,
  arg6: g,
  arg7: h,
  arg8: i,
  arg9: j,
  cb: fn() -> a,
) -> a {
  do_memoize(func, #(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), cb)
}

/// Same as memoize1 but with 10 args.
pub fn memoize10(
  func: fn(b, c, d, e, f, g, h, i, j, k) -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  arg4: e,
  arg5: f,
  arg6: g,
  arg7: h,
  arg8: i,
  arg9: j,
  arg10: k,
  cb: fn() -> a,
) -> a {
  do_memoize(
    func,
    #(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10),
    cb,
  )
}
