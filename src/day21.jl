module Day21
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(s::AbstractString) = map(toint ∘ last, splitlines(s))

###
### Part 1
###

function solve1(x)
    pos = copy(x)
    win_score = 1000
    scores = [0, 0]
    n = 0
    for i in 1:10_1000
        n += 3
        score = 3(n-1)
        player = isodd(i) ? 1 : 2
        pos[player] = mod1(pos[player] + score, 10)
        scores[player] += pos[player]
        scores[player] ≥ win_score && break
    end
    return minimum(scores) * n
end

###
### Part 2
###

function dice_outcomes()
    outcomes = Dict{Int, Int}()
    for i in 1:3, j in 1:3, k in 1:3
        outcomes[i+j+k] = get(outcomes, i+j+k, 0) + 1
    end
    return outcomes
end

const D = dice_outcomes()

function next(pos, score, dice_sum)
    pos = mod1(pos + dice_sum, 10)
    return pos, score + pos
end

function nwins(state, memo)
    p1, p2, s1, s2 = state
    haskey(memo, state) && return memo[state]
    nw = [0, 0]
    for (dice_sum, n) in D
        p1next, s1next = next(p1, s1, dice_sum)
        if s1next ≥ 21
            nw[1] += n
        else
            nextstate = (p2, p1next, s2, s1next)
            w = n * nwins(nextstate, memo)
            nw[1] += w[2]
            nw[2] += w[1]
        end
    end
    memo[state] = nw
    return nw
end

function solve2(x)
    pos1, pos2 = x
    memo = Dict{Tuple{Int, Int, Int, Int}, Vector{Int}}()
    return maximum(nwins((pos1, pos2, 0, 0), memo))
end

end  # module
