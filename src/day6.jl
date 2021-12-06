module Day6
include("utils.jl")
using StatsBase
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = split(x, ",") .|> toint

###
### Part 1
###

struct NFish
    n::Dict{Int, Int}
end
NFish(v::Vector{Int}) = NFish(countmap(v))
function increase_day(nf::NFish)
    new_n = Dict(d-1=>n for (d, n) in pairs(nf.n))
    haskey(new_n, -1) || return NFish(new_n)
    nm1 = pop!(new_n, -1)
    new_n[6] = get(new_n, 6, 0) + nm1
    new_n[8] = get(new_n, 8, 0) + nm1
    NFish(new_n)
end
nfish(nf::NFish) = sum(values(nf.n))

function solve(x, n)
    nf = NFish(x)
    for i in 1:n
        nf = increase_day(nf)
    end
    nfish(nf)
end

solve1(x) = solve(x, 80)

###
### Part 2
###

solve2(x) = solve(x, 256)

end  # module
