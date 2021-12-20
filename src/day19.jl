module Day19
include("utils.jl")
using .Utils
import .Utils: parse_input, parse_example
using DataStructures

export solve1, solve2, parse_input, parse_example

struct Point
    x::Int
    y::Int
    z::Int
end
Point() = Point(0,0,0)
Point(p) = Point(p...)
vector(p::Point) = [p.x, p.y, p.z]

distance(p1::Point, p2::Point) = sum(abs, vector(p1-p2))

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

Base.:+(a::Point, b::Point) = Point(vector(a) .+ vector(b))
Base.:-(a::Point, b::Point) = a + -b
Base.:-(a::Point) = Point(-1 .* vector(a))

struct Scanner
    beacons::Vector{Point}
    distances::Dict{Tuple{Int, Int}, Point}
    pos::Point
    rotation::Tuple{Int, Int, Int}
end
Scanner(beacons) = Scanner(beacons, distances(beacons), Point(), (0,0,0))
#Scanner(beacons, pos, rotation) = Scanner(beacons, distances(beacons), pos, rotation)
Scanner(s::Scanner, pos, rotation) = Scanner(s.beacons, s.distances, pos, rotation)

Base.length(s::Scanner) = length(s.beacons)

pos(s::Scanner, i) = Point((R[s.rotation] * vector(s.beacons[i]))...) - s.pos

function distances(beacons)
    len = length(beacons)
    d = Dict{Tuple{Int, Int}, Point}()
    for i in 1:(len-1), j in (i+1):len
        d[(i,j)] = beacons[j] - beacons[i]
    end
    return d
end

Base.show(io::IO, p::Point) = print(io, (p.x, p.y, p.z))
Base.show(io::IO, s::Scanner) = print(io::IO, s.beacons)

###
### Parse
###

Point(s::AbstractString) = Point(toint.(split(s, ','))...)

function Report(s::AbstractString)
    scanners = Dict{Int, Scanner}()
    for block in split(strip(s), "\n\n")
        lines = splitlines(block)
        n = split(lines[1])[3] |> toint
        scanners[n] = Scanner(Point.(lines[2:end]))
    end
    return scanners
end

parse_input(x::AbstractString) = Report(x)

###
### Part 1
###

isconsistent(a::Point, b::Point) = counter(abs.(vector(a))) == counter(abs.(vector(b)))
#find_rotation(a::Point, b::Point)


function consistent_rotations(s1, s2)
    d1, d2 = s1.distances, s2.distances
    candidates = Dict{Tuple{Int,Int,Int}, Vector{Tuple{Pair{Int,Int}, Pair{Int,Int}}}}()
    for (k1, v1) in d1, (k2, v2) in d2
        isconsistent(v1, v2) || continue
        for (key, r) in R
            p1 = R[s1.rotation] * vector(v1)
            p1 == r * vector(v2) || continue
            candidates[key] = push!(
                get(candidates, key, Tuple{Pair{Int,Int}, Pair{Int,Int}}[]),
                (k1[1]=>k2[1], k1[2] => k2[2])
            )
            length(candidates[key]) > 11 && break # shortcut
        end
    end
    return filter(x -> length(x.second) ≥ 12, candidates)
end

function check_overlap!(scanners, i, j)
    s1, s2 = scanners[i], scanners[j]
    rots = consistent_rotations(s1, s2)
    isempty(rots) && return false
    length(rots) > 1 && @warn "more than one candidate rotation $candidates"
    rot = first(keys(rots))
    cand1, cand2 = first(values(rots))[1][1]
    p1, p2 = vector(pos(s1, cand1)), vector(s2.beacons[cand2])
    p = Point((R[rot] * p2 - p1)...)
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
    beacons = Set{Point}()
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
