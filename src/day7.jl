module Day7
include("utils.jl")
using .Utils
import .Utils: parse_input
using Statistics

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = split(x, ",") .|> toint

###
### Part 1
###

totalfuel(x, pos) = sum(abs, x .- pos)

solve1(x) = totalfuel(x, median(x))

###
### Part 2
###

fuel2(n) = n * (n + 1) ÷ 2
totalfuel2(x, pos) = sum(fuel2 ∘ abs, x .- pos)

function solve2(x)
    pos = floor(Int, mean(x))
    return min(totalfuel2(x, pos), totalfuel2(x, pos+1))
end

end  # module
