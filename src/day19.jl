module Day19
include("utils.jl")
using .Utils
import .Utils: parse_input, parse_example
using DataStructures

export solve1, solve2, parse_input, parse_example

distance(p1, p2) = sum(abs, p1 - p2)

rotx(n) = Int[1 0 0; 0 cospi(n/2) -sinpi(n/2); 0 sinpi(n/2) cospi(n/2)]
roty(n) = Int[cospi(n/2) 0 sinpi(n/2); 0 1 0; -sinpi(n/2) 0 cospi(n/2)]
rotz(n) = Int[cospi(n/2) -sinpi(n/2) 0; sinpi(n/2) cospi(n/2) 0; 0 0 1]

function unique_rotations()
    R = Dict()
    for i in 0:3, j in 0:3, k in 0:3
        key = (i,j,k)
        r = rotx(i) * roty(j) * rotz(k)
        r in values(R) && continue
        R[key] = r
    end
    return R
end
const R = unique_rotations()

struct Scanner
    beacons::Vector{Vector{Int}}
    distances::Dict{Tuple{Int, Int}, Vector{Int}}
    pos::Vector{Int}
    rotation::Tuple{Int, Int, Int}
end
Scanner(beacons) = Scanner(beacons, distances(beacons), zeros(Int, 3), (0,0,0))
Scanner(s::Scanner, pos, rotation) = Scanner(s.beacons, s.distances, pos, rotation)

Base.length(s::Scanner) = length(s.beacons)

pos(s::Scanner, i) = (R[s.rotation] * s.beacons[i]) - s.pos

function distances(beacons)
    len = length(beacons)
    d = Dict{Tuple{Int, Int}, Vector{Int}}()
    for i in 1:(len-1), j in (i+1):len
        d[(i,j)] = beacons[j] - beacons[i]
    end
    return d
end

Base.show(io::IO, s::Scanner) = print(io::IO, s.beacons)

###
### Parse
###

Point(s::AbstractString) = toint.(split(s, ','))

function parse_input(x::AbstractString)
    scanners = Dict{Int, Scanner}()
    for block in split(strip(x), "\n\n")
        lines = splitlines(block)
        n = split(lines[1])[3] |> toint
        scanners[n] = Scanner(Point.(lines[2:end]))
    end
    return scanners
end

###
### Part 1
###

#isconsistent(a, b) = counter(abs.(a)) == counter(abs.(b))
#isconsistent(a, b) = Set(abs.(a)) == Set(abs.(b))
isconsistent(a, b) = sum(abs, a) == sum(abs, b)  # way faster than the options above


function check_rotation(s1, s2)
    p1 = map(i -> pos(s1, i), 1:length(s1))
    p2 = map(i -> pos(s2, i), 1:length(s2))
    common = intersect(p1, p2)
    return length(common) >= 12
end

function consistent_rotation(s1, s2)
    d1, d2 = s1.distances, s2.distances
    #checked = Set{Tuple{Vector{Int}, Tuple{Int, Int, Int}}}()
    for (k1, v1) in d1, (k2, v2) in d2
        isconsistent(v1, v2) || continue
        for (key, r) in R
            p1 = R[s1.rotation] * v1
            p1 == r * v2 || continue
            p1, p2 = pos(s1, k1[1]), s2.beacons[k2[1]]
            p = r * p2 - p1
            #(p, key) in checked && continue
            check_rotation(s1, Scanner(s2, p, key)) && return key, p
            #push!(checked, (p, key))
        end
    end
    return nothing
end

function check_overlap!(scanners, i, j)
    s1, s2 = scanners[i], scanners[j]
    rot = consistent_rotation(s1, s2)
    isnothing(rot) && return false
    rot, p = rot
    println("found consistency between $i and $j, rotation: $rot, translation: $pos")
    newscanner = Scanner(s2, p, rot)
    scanners[j] = newscanner
    return true
end

function lock!(scanners)
    locked = Set(0)
    queue = Set(0)
    while !isempty(queue)
        i = pop!(queue)
        for j in keys(scanners)
            j in locked && continue
            if check_overlap!(scanners, i, j)
                println("Scanner $j overlaps with scanner $i")
                push!(queue, j)
                push!(locked, j)
            end
        end
        keys(scanners) == locked && break
    end
    return scanners
end

function nbeacons(scanners)
    beacons = Set{Vector{Int}}()
    for scanner in values(scanners)
        for i in 1:length(scanner)
            p = pos(scanner, i)
            push!(beacons, p)
        end
    end
    return length(beacons)
end

solve1(scanners) = nbeacons(lock!(scanners))

###
### Part 2
###

function solve2(scanners)
    scanners = values(scanners) |> collect
    len = length(scanners)
    maxd = 0
    for i in 1:len-1, j in i+1:len
        maxd = max(maxd, distance(scanners[i].pos, scanners[j].pos))
    end
    return maxd
end

end  # module
