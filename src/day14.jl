module Day14
include("utils.jl")
using .Utils
import .Utils: parse_input
using StatsBase
using DataStructures

export solve1, solve2, parse_input

###
### Parse
###

function getrule(s::AbstractString)
    i, o = split(s, " -> ")
    return i => [i[1] * o, o * i[2]]
end

function parse_input(x::AbstractString)
    lines = splitlines(x)
    template = lines[1]
    rules = Dict((getrule(line) for line in lines[3:end]))
    return template, rules
end

###
### Part 1
###

function count(element, n, rules, memo)
    key = (element, n)
    haskey(memo, key) && return memo[key]
    if n==0
        res = counter(element[1])
        memo[key] = res
        return res
    end
    o = rules[element]
    res = merge(count(o[1], n-1, rules, memo), count(o[2], n-1, rules, memo))
    memo[key] = res
    return res
end

function solve(x, n=10)
    template, rules = x
    memo = Dict{Tuple{String, Int}, Accumulator{Char, Int64}}()
    elements = [template[i:i+1] for i in 1:length(template)-1]
    c = counter(elements[end][2])
    merge!(c, (count(e, n, rules, memo) for e in elements)...)
    return c |> values |> extrema |> collect |> diff |> first
end

solve1(x) = solve(x, 10)

###
### Part 2
###

solve2(x) = solve(x, 40)

end  # module
