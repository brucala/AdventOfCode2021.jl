module Day2
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

parse_input(x::AbstractString) = [Symbol(i) => toint(j) for (i,j) in split.(splitlines(x))]

function solve1(x)
    hpos, depth = 0, 0
    for (dir, n) in x
        if dir === :forward
            hpos += n
        else
            depth += dir === :down ? n : -n
        end
    end
    return hpos * depth
end

function solve2(x)
    hpos, depth, aim = 0, 0, 0
    for (dir, n) in x
        if dir === :forward
            hpos += n
            depth += aim * n
        else
            aim += dir === :down ? n : -n
        end
    end
    return hpos * depth
end

end  # module
