module Day17
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

getrange(s::AbstractString) = toint.(split(split(s, "=")[2], ".."))
parse_input(x::AbstractString) = getrange.(split(x, ","))

###
### Part 1
###

# solution x = vt - t(t-1)/2

function solve1(x)
    _, (y1, _) = x
    vmax = -y1 - 1
    return vmax * (vmax + 1) ÷ 2
end

###
### Part 2
###

function solve2(x)
    (x1, x2), (y1, y2) = x
    vyrange = y1:(-y1 - 1)
    vxrange = ceil(Int, (-1 + √(1 + 8x1)) / 2):x2
    trange = 1:-2y1
    sols = Set{Tuple{Int,Int}}()
    for vx in vxrange, vy in vyrange
        for t in trange
            x = t > vx ? vx * (vx + 1) ÷ 2 : vx * t - t * (t - 1) / 2
            y = vy * t - t * (t - 1) / 2
            x1 ≤ x ≤ x2 && y1 ≤ y ≤ y2 && push!(sols, (vx, vy))
        end
    end
    return length(sols)
end

end  # module
