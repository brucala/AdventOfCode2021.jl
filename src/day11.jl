module Day11
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = getgrid(x, fmap=toint)

###
### Part 1
###

function step!(x)
    x .+= 1
    n, m = size(x)
    for i in 1:n, j in 1:m
        if x[i, j] == 10
            flash!(x, i, j)
        end
    end
    return sum(x .== 0)
end

function flash!(x, i, j)
    x[i, j] = 0
    for (ii, jj) in neighbors(x, i, j)
        level = x[ii, jj]
        if level >= 9
            flash!(x, ii, jj)
        elseif level > 0
            x[ii, jj] += 1
        end
    end
end

function neighbors(x, i, j)
    n, m = size(x)
    return [
        (i+ii, j+jj)
        for ii in -1:1, jj in -1:1
        if (1 ≤ i+ii ≤ n) && (1 ≤ j+jj ≤ m) && !(ii==0 && jj==0)
    ]
end

function solve1(x)
    n = 0
    levels = copy(x)
    for _ in 1:100
        n += step!(levels)
    end
    return n
end

###
### Part 2
###

function solve2(x)
    levels = copy(x)
    len = length(x)
    for i in 1:500
        n = step!(levels)
        n == len && return i
    end
end

end  # module
