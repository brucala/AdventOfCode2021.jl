module Day25
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    g = getgrid(x)
    return g .== '>', g .== 'v'
end

###
### Part 1
###

free(e, s) = .!(e .|| s)

const DIR = Dict(1=>(0, 1), 2=>(1, 0))

function move(x, dim)
    dir = DIR[dim]
    dots = free(x...)
    canmove = x[dim] .&& circshift(dots, .-dir)
    x[dim][canmove] .= false
    newpos = circshift(canmove, dir)
    x[dim][newpos] .= true
    return x
end

moveeast(x) = move(x, 1)
movesouth(x) = move(x, 2)

step(e, s) = (movesouth ∘ moveeast)(copy.((e, s)))

function solve1(x)
    e, s = x
    for i in 1:1000
        ee, ss = step(e, s)
        ee == e && ss == s && return i
        e, s = ee, ss
    end
end

end  # module
