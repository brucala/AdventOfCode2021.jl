module Day1
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

parse_input(x) = parse_ints(x)

solve1(x) = sum(diff(x) .> 0)

solve2(x) = solve1([sum(x[i:i+2]) for i in 1:length(x)-2])

end  # module
