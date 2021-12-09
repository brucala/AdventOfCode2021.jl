module Day9
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = getgrid(x) .|> toint

###
### Part 1
###

function neighbors(x, i, j)
    n, m = size(x)
    ind = CartesianIndex.([
        (i,j) .+ (k,l)
        for (k,l) in [(1, 0), (-1, 0), (0, 1), (0, -1)]
            if 1 ≤ i+k ≤ n && 1 ≤ j+l ≤ m
    ])
    return ind
end

function solve1(x)
    n, m = size(x)
    risklevel = 0
    for i in 1:n, j in 1:m
        all(x[i,j] .< x[neighbors(x,i,j)]) && (risklevel += 1 + x[i,j])
    end
    return risklevel
end

###
### Part 2
###

function lowpoints(x)
    n, m = size(x)
    lp = Vector{CartesianIndex{2}}()
    for i in 1:n, j in 1:m
        all(x[i,j] .< x[neighbors(x,i,j)]) && push!(lp, CartesianIndex(i,j))
    end
    return lp
end
function basinsize(x, p)
    basin = zeros(Bool, size(x))
    fillbasin!(basin, x, p)
    return sum(basin)
end
function fillbasin!(basin, x, p)
    basin[p] = true
    for n in neighbors(x, Tuple(p)...)
        (x[n] == 9 || basin[n]) && continue
        fillbasin!(basin, x, n)
    end
end
function solve2(x)
    basins = Vector{Int}()
    for p in lowpoints(x)
        push!(basins, basinsize(x, p))
    end
    return prod(sort(basins, rev=true)[1:3])
end

end  # module
