# 🎄Advent of Code🎄

Solutions to https://adventofcode.com in Elixir

## Example

```
mix aoc --year=22 --day=2
```

## Tests

```
mix test
```

## Profiling

Use the `--profile` flag to generate trace output.

```
mix aoc --year=21 --day=18 --profile
```
This will generate an `fprof.trace` file. This can, for example, be converted into a callgrind (`erlgrind fprof.trace callgrind.out`) which can be visualised with [kcachegrind](https://kcachegrind.github.io/html/Home.html)
