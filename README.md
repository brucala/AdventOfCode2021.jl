# Advent of Code 2021

Solutions to [Advent of Code 2021 edition](https://adventofcode.com/2021) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬────────────┬────────┐
│ day │ part │       time │     memory │ allocs │
├─────┼──────┼────────────┼────────────┼────────┤
│   1 │    0 │ 273.183 μs │ 413.09 KiB │   6040 │
│   1 │    1 │   3.463 μs │  20.30 KiB │      4 │
│   1 │    2 │  82.319 μs │ 254.58 KiB │   2003 │
├─────┼──────┼────────────┼────────────┼────────┤
│   2 │    0 │ 554.643 μs │ 276.62 KiB │   2038 │
│   2 │    1 │   1.031 μs │    0 bytes │      0 │
│   2 │    2 │   1.329 μs │    0 bytes │      0 │
├─────┼──────┼────────────┼────────────┼────────┤
│   3 │    0 │ 493.720 μs │ 257.31 KiB │     61 │
│   3 │    1 │  10.964 μs │   3.52 KiB │     65 │
│   3 │    2 │  87.752 μs │  20.88 KiB │    333 │
├─────┼──────┼────────────┼────────────┼────────┤
│   4 │    0 │ 955.197 μs │ 572.00 KiB │   6052 │
│   4 │    1 │ 270.800 μs │  92.25 KiB │   1608 │
│   4 │    2 │ 271.643 μs │  92.66 KiB │   1608 │
└─────┴──────┴────────────┴────────────┴────────┘

```

> **Part 0** refers to the **parsing of the input data**.

## Other CLI tools

To generate (src and test) templates for a given day:
```
$ julia cli/generate_day.jl -h
usage: generate_day.jl [-h] nday

positional arguments:
  nday        day number for files to be generated

optional arguments:
  -h, --help  show this help message and exit
```

To download the input data of a given day:
```
$ julia cli/get_input.jl -h
usage: get_input.jl [-d DAY] [-h]

optional arguments:
  -d, --day DAY  day number for the input to be downloaded. If not
                 given take today's input (type: Int64)
  -h, --help     show this help message and exit
```
