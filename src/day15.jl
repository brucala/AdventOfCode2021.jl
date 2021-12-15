module Day15
include("utils.jl")
using .Utils
import .Utils: parse_input
using DataStructures

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = getgrid(x, fmap=toint)

###
### Part 1
###

function solve(riskgrid)
    minrisk = repeat([typemax(Int)], size(riskgrid)...)
    pq = PriorityQueue((1, 1) => -riskgrid[1, 1])
    n, m = size(riskgrid)
    while !isempty(pq)
        pos, risk = dequeue_pair!(pq)
        risk < minrisk[pos...] || continue
        minrisk[pos...] = risk
        neighbors = [
            pos .+ Δ
            for Δ in [(1, 0), (0,1), (-1, 0), (0, -1)]
            if 1 ≤ pos[1] .+ Δ[1] ≤ n && 1 ≤ pos[2] .+ Δ[2] ≤ m
        ]
        for npos in neighbors
            nrisk = risk + riskgrid[npos...]
            nrisk > minrisk[npos...] && continue
            haskey(pq, npos) && pq[npos]<=risk && continue
            pq[npos] = risk
        end
    end
    return minrisk[n,m]
end

solve1(x) = solve(x)

###
### Part 2
###

struct Riskgrid
    riskgrid::Matrix{Int}
end
function Base.getindex(g::Riskgrid, i, j)
    n, m = size(g.riskgrid)
    return mod1(g.riskgrid[mod1(i, n), mod1(j, m)] + (i-1) ÷ n + (j-1) ÷ m, 9)
end
Base.size(g::Riskgrid) = 5 .* size(g.riskgrid)

solve2(x) = solve(Riskgrid(x))

end  # module
