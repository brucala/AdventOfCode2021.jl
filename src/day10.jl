module Day10
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = splitlines(x)

###
### Part 1
###

const error_table = Dict(
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137,
)

const openchars = "([{<"
const closechars = Dict(o => c for (o,c) in zip("([{<", ")]}>"))

function error_score(line)
    seen = Vector{Char}()
    for c in line
        if c in openchars
            push!(seen, c)
            continue
        end
        prev = pop!(seen)
        c != closechars[prev] && return error_table[c], seen
    end
    return 0, seen
end

function solve1(x)
    score = 0
    for line in x
        score += error_score(line)[1]
    end
    return score
end

###
### Part 2
###
const completion_table = Dict(c => i for (i, c) in enumerate(openchars))
function completion_score(x)
    score = 0
    for c in reverse(x)
        score *= 5
        score += completion_table[c]
    end
    return score
end

function solve2(x)
    scores = Vector{Int}()
    for line in x
        escore, left = error_score(line)
        if escore == 0
            push!(scores, completion_score(left))
        end
    end
    sort!(scores)
    @assert isodd(length(scores))
    return scores[length(scores) ÷ 2 + 1]
end

end  # module
