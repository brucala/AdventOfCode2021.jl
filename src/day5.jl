module Day5
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = Line.(splitlines(x))

struct Point
    x::Int
    y::Int
end
Point(s::AbstractString) = Point(toint.(split(s,","))...)
struct Line
    p1::Point
    p2::Point
end
Line(s::AbstractString) = Line(Point.(split(s, "->"))...)

###
### Part 1
###

is_horizontal(l::Line) = l.p1.x == l.p2.x
is_vertical(l::Line) = l.p1.y == l.p2.y

xrange(l::Line) = range(l.p1.x, l.p2.x, step=l.p1.x < l.p2.x ? 1 : -1)
yrange(l::Line) = range(l.p1.y, l.p2.y, step=l.p1.y < l.p2.y ? 1 : -1)
hpoints(l::Line) = [Point(l.p1.x, y) for y in yrange(l)]
vpoints(l::Line) = [Point(x, l.p1.y) for x in xrange(l)]
dpoints(l::Line) = [Point(x, y) for (x,y) in zip(xrange(l), yrange(l))]

function solve(lines, part2=false)
    countpoints = Dict{Point, Int}()
    for line in lines
        pts = is_horizontal(line) ? hpoints(line) : is_vertical(line) ? vpoints(line) : nothing
        if isnothing(pts)
            part2 || continue
            pts = dpoints(line)
        end
        for p in pts
            countpoints[p] = get(countpoints, p, 0) + 1
        end
    end
    return sum(values(countpoints) .> 1)
end

solve1(lines) = solve(lines)

###
### Part 2
###

solve2(lines) = solve(lines, true)

end  # module
