module Day22
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

getranges(s) = getrange.(split(s, ","))
getrange(s) = UnitRange(toint.(split(s[3:end], ".."))...)

function parse_input(x::AbstractString)
    #out = Tuple{Bool, Vector{UnitRange{Int}}}[]
    out = Tuple{Bool, Cuboid}[]
    for line in splitlines(x)
        sline = split(line, " ")
        turnon = sline[1] == "on"
        cuboid = Cuboid(getranges(sline[2]))
        push!(out, (turnon, cuboid))
        #ranges = getranges(sline[2])
        #push!(out, (turnon, ranges))
    end
    return out
end

###
### Part 1
###

validrange(x) = (max(first(x), -50):min(last(x), 50)) .+ 51
function solve1(lines)
    M = falses(101, 101, 101)
    for line in lines
        turnon, cuboid = line
        x, y, z = validrange.(cuboid.ranges)
        M[x, y, z] .= turnon
    end
    return sum(M)
end

###
### Part 2
###

struct Cuboid
    ranges::NTuple{3, UnitRange}
end
Cuboid(c::Vector{UnitRange{Int}}) = Cuboid((c[1], c[2], c[3]))

Base.isdisjoint(c1::Cuboid, c2::Cuboid) = any(map(x -> isdisjoint(x...), zip(c1.ranges, c2.ranges)))
Base.intersect(c1::Cuboid, c2::Cuboid) = Cuboid(map(x -> intersect(x...), zip(c1.ranges, c2.ranges)))
Base.isempty(c::Cuboid) = any(isempty.(c.ranges))

Base.split(r1::UnitRange, r2::UnitRange) = [first(r1):first(r2)-1, r2, last(r2)+1:last(r1)]
function Base.split(c1::Cuboid, c2::Cuboid)
    xs, ys, zs = split.(c1.ranges, c2.ranges)
    cuboids = Cuboid[]
    for x in xs, y in ys, z in zs
        any(isempty, (x, y, z)) && continue
        push!(cuboids, Cuboid((x, y, z)))
    end
    return cuboids
end

function Base.setdiff(c1::Cuboid, c2::Cuboid)
    c = intersect(c1, c2)
    isempty(c) && return [c1]
    return filter(!=(c), split(c1, c))
end
function Base.setdiff(cuboids::Vector{Cuboid}, cuboid::Cuboid)
    v = Cuboid[]
    for c in cuboids
        append!(v, setdiff(c, cuboid))
    end
    return v
end

ncubes(c::Cuboid) = prod(length, c.ranges)

function solve2(lines)
    cuboids = Cuboid[]
    for line in lines
        turnon, cuboid = line
        #cuboid = Cuboid(ranges)
        cuboids = setdiff(cuboids, cuboid)
        turnon && push!(cuboids, cuboid)
    end
    return sum(ncubes, cuboids)
end

end  # module
