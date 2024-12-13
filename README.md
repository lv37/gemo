# gemo

[![Package Version](https://img.shields.io/hexpm/v/gemo)](https://hex.pm/packages/gemo)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gemo/)

```sh
gleam add gemo
```
```gleam
import gemo
import bool

fn fib(n) {
  use <- gemo.memoize1(fib, n)
  use <- bool.guard(n <= 1, n)
  fib(n - 1) + fib(n - 2)
}
```

Further documentation can be found at <https://hexdocs.pm/gemo>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
