import gleam/int
import gleam/result
import lamb

const table_name = "@@#!*(#@&!_memoization_cache"

@external(javascript, "./gemo_ffi.mjs", "memoize")
fn do_memoize(key: a, args: b, cb: fn() -> c) -> c {
  let table = get_table()

  case lamb.lookup(table, #(key, args)) {
    [] -> {
      let out = cb()
      lamb.insert(table, #(key, args), out)
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

@external(javascript, "./gemo_ffi.mjs", "cache_size")
pub fn cache_size() -> Int {
  get_table().reference
  |> table_size
}

@external(erlang, "gemo_ffi", "table_count")
fn table_count(table: a) -> Int

@external(javascript, "./gemo_ffi.mjs", "cache_count")
pub fn cache_count() -> Int {
  get_table().reference
  |> table_count
}

pub fn cache_density() -> Float {
  { cache_size() |> int.to_float() } /. { cache_count() |> int.to_float() }
}

pub fn memoize0(key: fn() -> a, cb: fn() -> a) -> a {
  do_memoize(key, #(), cb)
}

pub fn memoize1(key: fn(b) -> a, arg1: b, cb: fn() -> a) -> a {
  do_memoize(key, #(arg1), cb)
}

pub fn memoize2(key: fn() -> a, arg1: b, arg2: c, cb: fn() -> a) -> a {
  do_memoize(key, #(arg1, arg2), cb)
}

pub fn memoize3(key: fn() -> a, arg1: b, arg2: c, arg3: d, cb: fn() -> a) -> a {
  do_memoize(key, #(arg1, arg2, arg3), cb)
}

pub fn memoize4(
  key: fn() -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  arg4: e,
  cb: fn() -> a,
) -> a {
  do_memoize(key, #(arg1, arg2, arg3, arg4), cb)
}

pub fn memoize5(
  key: fn() -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  arg4: e,
  arg5: f,
  cb: fn() -> a,
) -> a {
  do_memoize(key, #(arg1, arg2, arg3, arg4, arg5), cb)
}

pub fn memoize6(
  key: fn() -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  arg4: e,
  arg5: f,
  arg6: g,
  cb: fn() -> a,
) -> a {
  do_memoize(key, #(arg1, arg2, arg3, arg4, arg5, arg6), cb)
}

pub fn memoize7(
  key: fn() -> a,
  arg1: b,
  arg2: c,
  arg3: d,
  arg4: e,
  arg5: f,
  arg6: g,
  arg7: h,
  cb: fn() -> a,
) -> a {
  do_memoize(key, #(arg1, arg2, arg3, arg4, arg5, arg6, arg7), cb)
}

pub fn memoize8(
  key: fn() -> a,
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
  do_memoize(key, #(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8), cb)
}

pub fn memoize9(
  key: fn() -> a,
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
  do_memoize(key, #(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), cb)
}

pub fn memoize10(
  key: fn() -> a,
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
    key,
    #(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10),
    cb,
  )
}
