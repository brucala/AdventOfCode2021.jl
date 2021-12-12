module Day12
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    cavemap = Dict{String, Vector{String}}()
    for line in splitlines(x)
        c1, c2 = split(line, "-")
        c2 != "start" && (cavemap[c1] = push!(get(cavemap, c1, String[]), c2))
        c1 != "start" && (cavemap[c2] = push!(get(cavemap, c2, String[]), c1))
    end
    return cavemap
end

###
### Part 1
###

function npaths(cave, room, seen)
    room == "end" && return 1
    newseen = copy(seen)
    room == lowercase(room) && push!(newseen, room)
    n = 0
    for nextroom in cave[room]
        if nextroom ∉ seen
            n += npaths(cave, nextroom, newseen)
        end
    end
    return n
end

solve1(x) = npaths(x, "start", Set{String}())

###
### Part 2
###

function npaths2(cave, room, seen, twice)
    room == "end" && return 1
    newseen = copy(seen)
    room == lowercase(room) && push!(newseen, room)
    n = 0
    for nextroom in cave[room]
        if nextroom ∉ seen
            n += npaths2(cave, nextroom, newseen, twice)
        elseif !twice
            n += npaths2(cave, nextroom, newseen, true)
        end
    end
    return n
end

solve2(x) = npaths2(x, "start", Set{String}(), false)

end  # module
