# Advent of Code 2021

Solutions to [Advent of Code 2021 edition](https://adventofcode.com/2021) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬────────────┬────────┐
│ day │ part │       time │     memory │ allocs │
├─────┼──────┼────────────┼────────────┼────────┤
│   1 │    0 │ 274.137 μs │ 413.09 KiB │   6040 │
│   1 │    1 │   3.530 μs │  20.30 KiB │      4 │
│   1 │    2 │  83.483 μs │ 254.58 KiB │   2003 │
├─────┼──────┼────────────┼────────────┼────────┤
│   2 │    0 │ 550.835 μs │ 276.62 KiB │   2038 │
│   2 │    1 │   1.065 μs │    0 bytes │      0 │
│   2 │    2 │   1.319 μs │    0 bytes │      0 │
├─────┼──────┼────────────┼────────────┼────────┤
│   3 │    0 │ 492.674 μs │ 257.31 KiB │     61 │
│   3 │    1 │  10.982 μs │   3.52 KiB │     65 │
│   3 │    2 │  90.417 μs │  20.88 KiB │    333 │
├─────┼──────┼────────────┼────────────┼────────┤
│   4 │    0 │ 960.043 μs │ 572.00 KiB │   6052 │
│   4 │    1 │ 269.375 μs │  92.25 KiB │   1608 │
│   4 │    2 │ 269.933 μs │  92.66 KiB │   1608 │
├─────┼──────┼────────────┼────────────┼────────┤
│   5 │    0 │   1.399 ms │ 731.61 KiB │  11010 │
│   5 │    1 │  11.840 ms │  10.68 MiB │    369 │
│   5 │    2 │  20.450 ms │  12.46 MiB │    542 │
├─────┼──────┼────────────┼────────────┼────────┤
│   6 │    0 │  43.665 μs │  29.72 KiB │     36 │
│   6 │    1 │  26.183 μs │  50.72 KiB │    326 │
│   6 │    2 │  80.533 μs │ 155.22 KiB │   1030 │
├─────┼──────┼────────────┼────────────┼────────┤
│   7 │    0 │ 133.191 μs │  65.88 KiB │     37 │
│   7 │    1 │   4.086 μs │  15.88 KiB │      2 │
│   7 │    2 │   4.173 μs │  15.88 KiB │      2 │
├─────┼──────┼────────────┼────────────┼────────┤
│   8 │    0 │   1.526 ms │   1.47 MiB │  13637 │
│   8 │    1 │  20.338 μs │  43.75 KiB │    400 │
│   8 │    2 │   2.071 ms │   1.98 MiB │  19232 │
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
