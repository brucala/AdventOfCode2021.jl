module Day13
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

struct Fold
    axis::Int
    ifold::Int
end

struct Paper
    points::Set{Pair{Int}}
    folds::Vector{Fold}
end
Paper() = Paper(Set{Pair{Int}}(), Fold[])

add_point!(p::Paper, x, y) = push!(p.points, x=>y)
add_point!(p::Paper, line::AbstractString) = add_point!(p, toint.(split(line, ','))...)

add_fold!(p::Paper, axis, ifold) = push!(p.folds, Fold(axis, ifold))
function add_fold!(p::Paper, line::AbstractString)
    axis, n = split(line, '=')
    axis = axis[end] == 'x' ? 1 : 2
    add_fold!(p, axis, toint(n))
end

function parse_input(x::AbstractString)
    paper = Paper()
    ispoint = true
    for line in splitlines(x)
        line == "" && (ispoint=false; continue)
        if ispoint
            add_point!(paper, line)
        else
            add_fold!(paper, line)
        end
    end
    return paper
end


Base.length(p::Paper) = length(p.points)

function fold(p::Paper)
    fold = p.folds[1]
    newpoints = Set{Pair{Int}}()
    for point in p.points
        if point[fold.axis] == fold.ifold
            continue
        elseif point[fold.axis] < fold.ifold
                push!(newpoints, point)
        else
            pt = collect(point)
            pt[fold.axis] = 2 * (fold.ifold) - pt[fold.axis]
            push!(newpoints, Pair(pt...))
        end
    end
    return Paper(newpoints, p.folds[2:end])
end

function solve1(paper)
    return length(fold(paper))
end

###
### Part 2
###

function Base.size(p::Paper)
    n, m = 0, 0
    for point in p.points
        n = max(n, point.first)
        m = max(m, point.second)
    end
    return n+1, m+1
end

function Base.show(io::IO, p::Paper)
    n, m = size(p)
    for y in 0:m-1
        for x in 0:n-1
            if (x => y) in p.points
                print(io, 'o')
            else
                print(io, ' ')
            end
        end
        println(io)
    end
end

function solve2(paper)
    while true
        isempty(paper.folds) && return paper
        paper = fold(paper)
    end
end

end  # module
