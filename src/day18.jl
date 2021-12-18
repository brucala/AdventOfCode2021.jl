module Day18
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

struct SFNumber
    left::Union{Int,SFNumber}
    right::Union{Int,SFNumber}
end

function Base.reduce(sf::SFNumber)
    nlevels(sf) > 4 && return reduce(explode(sf, 4)[1])
    issplitable(sf) && return reduce(split(sf))
    return sf
end

SFNumber(v::Vector) = SFNumber(SFNumber(first(v)), SFNumber(last(v)))
SFNumber(n::Int) = n

Base.show(io::IO, sf::SFNumber) = print(io, "[", sf.left, ", ", sf.right, "]")

Base.:+(a::SFNumber, b::SFNumber) = reduce(SFNumber(a, b))

Base.:+(sf::SFNumber, n::Int) = n == 0 ? sf : SFNumber(sf.left, sf.right + n)
Base.:+(n::Int, sf::SFNumber) = n == 0 ? sf : SFNumber(n + sf.left, sf.right)

nlevels(sf::SFNumber) = max(nlevels(sf.left), nlevels(sf.right)) + 1
nlevels(n::Int) = 0

issplitable(sf::SFNumber) = issplitable(sf.left) || issplitable(sf.right)
issplitable(n::Int) = n > 9

function split(sf::SFNumber)
    issplitable(sf.left) && return SFNumber(split(sf.left), sf.right)
    issplitable(sf.right) && return SFNumber(sf.left, split(sf.right))
    @warn "didn't split"
end
split(n::Int) = SFNumber(div(n, 2, RoundDown), div(n, 2, RoundUp))


function explode(sf::SFNumber, maxlevel)
    if maxlevel == 0
        @assert nlevels(sf) == 1
        return 0, (sf.left, sf.right)
    elseif nlevels(sf.left) == maxlevel
        newleft, (l, r) = explode(sf.left, maxlevel - 1)
        return SFNumber(newleft, r + sf.right), (l, 0)
    elseif nlevels(sf.right) == maxlevel
        newright, (l, r) = explode(sf.right, maxlevel - 1)
        return SFNumber(sf.left + l, newright), (0, r)
    end
    @warn "didn't explode"
end

###
### Parse
###

function parse_input(x::AbstractString)
    homework = SFNumber[]
    for line in splitlines(x)
        sfvector = eval(Meta.parse(line))
        push!(homework, SFNumber(sfvector))
    end
    return homework
end

###
### Part 1
###

magnitude(n::Int) = n
magnitude(sf::SFNumber) = 3magnitude(sf.left) + 2magnitude(sf.right)

Base.sum(sf::Vector{SFNumber}) = +(sf[1], sf[2:end]...)

solve1(x) = magnitude(sum(x))

###
### Part 2
###

function solve2(x)
    sol = 0
    for i in 1:length(x)-1, j in i+1:length(x)
        sol = max(sol, magnitude(x[i] + x[j]))
        sol = max(sol, magnitude(x[j] + x[i]))
    end
    return sol
end

end  # module
