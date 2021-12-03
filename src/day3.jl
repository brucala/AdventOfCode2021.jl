module Day3
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

parse_input(x::AbstractString) = parse.(Bool, getgrid(x))

rate(x) = parse(Int, join(string.(x, base=2)), base=2)

function solve1(x)
    γ = sum(x, dims=1) .>= size(x, 1) / 2
    return rate(γ) * rate(.!γ)
end


function filter(x, pos, f)
    b = f.(sum(x[:, pos]), size(x, 1) / 2)
    return x[:, pos] .== b
end
function rating(x, oxygen=true)
    for i in 1:size(x, 2)
        size(x, 1) == 1 && return rate(x)
        x = x[filter(x, i, oxygen ? (>=) : <), :]
    end
    return rate(x)
end

solve2(x) = rating(x) * rating(x, false)

end  # module
