# Advent of Code 2021

Solutions to [Advent of Code 2021 edition](https://adventofcode.com/2021) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬────────────┬────────┐
│ day │ part │       time │     memory │ allocs │
├─────┼──────┼────────────┼────────────┼────────┤
│   1 │    0 │ 274.614 μs │ 413.09 KiB │   6040 │
│   1 │    1 │   3.479 μs │  20.30 KiB │      4 │
│   1 │    2 │  83.489 μs │ 254.58 KiB │   2003 │
├─────┼──────┼────────────┼────────────┼────────┤
│   2 │    0 │ 553.574 μs │ 276.62 KiB │   2038 │
│   2 │    1 │   1.058 μs │    0 bytes │      0 │
│   2 │    2 │   1.345 μs │    0 bytes │      0 │
├─────┼──────┼────────────┼────────────┼────────┤
│   3 │    0 │ 493.699 μs │ 257.31 KiB │     61 │
│   3 │    1 │  11.008 μs │   3.52 KiB │     65 │
│   3 │    2 │  88.038 μs │  20.88 KiB │    333 │
├─────┼──────┼────────────┼────────────┼────────┤
│   4 │    0 │ 973.691 μs │ 572.00 KiB │   6052 │
│   4 │    1 │ 269.557 μs │  92.25 KiB │   1608 │
│   4 │    2 │ 270.792 μs │  92.66 KiB │   1608 │
├─────┼──────┼────────────┼────────────┼────────┤
│   5 │    0 │   1.415 ms │ 731.61 KiB │  11010 │
│   5 │    1 │  11.237 ms │  10.68 MiB │    369 │
│   5 │    2 │  19.954 ms │  12.46 MiB │    542 │
├─────┼──────┼────────────┼────────────┼────────┤
│   6 │    0 │  44.656 μs │  29.72 KiB │     36 │
│   6 │    1 │  24.882 μs │  50.72 KiB │    326 │
│   6 │    2 │  76.703 μs │ 155.22 KiB │   1030 │
├─────┼──────┼────────────┼────────────┼────────┤
│   7 │    0 │ 134.403 μs │  65.88 KiB │     37 │
│   7 │    1 │   4.071 μs │  15.88 KiB │      2 │
│   7 │    2 │   4.184 μs │  15.88 KiB │      2 │
├─────┼──────┼────────────┼────────────┼────────┤
│   8 │    0 │   1.513 ms │   1.47 MiB │  13637 │
│   8 │    1 │  20.084 μs │  43.75 KiB │    400 │
│   8 │    2 │   2.079 ms │   1.98 MiB │  19232 │
├─────┼──────┼────────────┼────────────┼────────┤
│   9 │    0 │ 335.781 μs │ 273.94 KiB │     57 │
│   9 │    1 │   2.987 ms │   7.32 MiB │  80000 │
│   9 │    2 │   5.206 ms │  13.16 MiB │ 116603 │
├─────┼──────┼────────────┼────────────┼────────┤
│  10 │    0 │ 141.511 μs │  29.52 KiB │     33 │
│  10 │    1 │ 265.985 μs │  25.78 KiB │    440 │
│  10 │    2 │ 276.455 μs │  34.42 KiB │    501 │
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
