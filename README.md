# Advent of Code 2021

Solutions to [Advent of Code 2021 edition](https://adventofcode.com/2021) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬────────────┬─────────┐
│ day │ part │       time │     memory │  allocs │
├─────┼──────┼────────────┼────────────┼─────────┤
│   1 │    0 │ 273.291 μs │ 413.09 KiB │    6040 │
│   1 │    1 │   3.688 μs │  20.30 KiB │       4 │
│   1 │    2 │  84.512 μs │ 254.58 KiB │    2003 │
├─────┼──────┼────────────┼────────────┼─────────┤
│   2 │    0 │ 552.503 μs │ 276.62 KiB │    2038 │
│   2 │    1 │   1.234 μs │    0 bytes │       0 │
│   2 │    2 │   1.371 μs │    0 bytes │       0 │
├─────┼──────┼────────────┼────────────┼─────────┤
│   3 │    0 │ 512.810 μs │ 257.31 KiB │      61 │
│   3 │    1 │  11.358 μs │   3.52 KiB │      65 │
│   3 │    2 │  91.153 μs │  20.88 KiB │     333 │
├─────┼──────┼────────────┼────────────┼─────────┤
│   4 │    0 │   1.026 ms │ 572.00 KiB │    6052 │
│   4 │    1 │ 269.317 μs │  92.25 KiB │    1608 │
│   4 │    2 │ 270.040 μs │  92.66 KiB │    1608 │
├─────┼──────┼────────────┼────────────┼─────────┤
│   5 │    0 │   1.391 ms │ 731.61 KiB │   11010 │
│   5 │    1 │  11.189 ms │  10.68 MiB │     369 │
│   5 │    2 │  19.815 ms │  12.46 MiB │     542 │
├─────┼──────┼────────────┼────────────┼─────────┤
│   6 │    0 │  43.885 μs │  29.72 KiB │      36 │
│   6 │    1 │  25.294 μs │  50.72 KiB │     326 │
│   6 │    2 │  77.155 μs │ 155.22 KiB │    1030 │
├─────┼──────┼────────────┼────────────┼─────────┤
│   7 │    0 │ 133.468 μs │  65.88 KiB │      37 │
│   7 │    1 │   4.062 μs │  15.88 KiB │       2 │
│   7 │    2 │   4.265 μs │  15.88 KiB │       2 │
├─────┼──────┼────────────┼────────────┼─────────┤
│   8 │    0 │   1.516 ms │   1.47 MiB │   13637 │
│   8 │    1 │  20.276 μs │  43.75 KiB │     400 │
│   8 │    2 │   2.085 ms │   1.98 MiB │   19232 │
├─────┼──────┼────────────┼────────────┼─────────┤
│   9 │    0 │ 335.702 μs │ 273.94 KiB │      57 │
│   9 │    1 │   3.060 ms │   7.32 MiB │   80000 │
│   9 │    2 │   5.349 ms │  13.16 MiB │  116603 │
├─────┼──────┼────────────┼────────────┼─────────┤
│  10 │    0 │ 147.254 μs │  29.52 KiB │      33 │
│  10 │    1 │ 265.229 μs │  25.78 KiB │     440 │
│  10 │    2 │ 274.964 μs │  34.42 KiB │     501 │
├─────┼──────┼────────────┼────────────┼─────────┤
│  11 │    0 │  12.732 μs │   6.00 KiB │      44 │
│  11 │    1 │ 441.915 μs │ 613.30 KiB │    6612 │
│  11 │    2 │   1.098 ms │   1.49 MiB │   16473 │
├─────┼──────┼────────────┼────────────┼─────────┤
│  12 │    0 │  27.911 μs │  19.36 KiB │     271 │
│  12 │    1 │   5.364 ms │   7.59 MiB │   91585 │
│  12 │    2 │ 217.617 ms │ 243.43 MiB │ 2938737 │
└─────┴──────┴────────────┴────────────┴─────────┘

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
