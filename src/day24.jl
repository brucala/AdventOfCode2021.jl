module Day24
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function int_or_symbol(s)
    n = tryparse(Int, s)
    return isnothing(n) ? Symbol(s) : n
end
parse_input(x::AbstractString) = map(line -> tuple(int_or_symbol.(split(line))...), splitlines(x))

###
### Part 1
###

mutable struct ALU
    program::Vector{Tuple{Symbol, Symbol, Vararg{Union{Symbol, Int}}}}
    x::Int
    y::Int
    z::Int
    w::Int
end
ALU(program) = ALU(program, 0, 0, 0, 0)

Base.copy(alu) = ALU(copy(alu.program), alu.x, alu.y, alu.z, alu.w)

instruction(alu::ALU) = alu.program[1]

function run(alu::ALU, n::Int)
    (ins, args...) = popfirst!(alu.program)
    ins === :inp && (args = (args[1], n))
    run(alu, ins, args...)
end

run(alu::ALU, ins::Symbol, a, b) = run(Val(ins), alu, a, value(alu, a), value(alu, b))

run(::Val{:inp}, alu, var, a, b) = setfield!(alu, var, b)
run(::Val{:add}, alu, var, a, b) = setfield!(alu, var, a + b)
run(::Val{:mul}, alu, var, a, b) = setfield!(alu, var, a * b)
run(::Val{:div}, alu, var, a, b) = setfield!(alu, var, fld(a, b))
run(::Val{:mod}, alu, var, a, b) = setfield!(alu, var, a % b)
run(::Val{:eql}, alu, var, a, b) = setfield!(alu, var, a == b ? 1 : 0)

function decrease(model_number, i)
    model_number = copy(model_number)
    model_number[i+1:end] .= 9
    model_number[i] -= 1
    return model_number[i] == 0 ? decrease(model_number, i-1) : (model_number, i-1)
end

value(::ALU, v::Int) = v
value(alu::ALU, v::Symbol) = getfield(alu, v)

function runall(program, model_number)
    alu = ALU(program)
    i = 0
    while !isempty(alu.program)
        ins, _ = instruction(alu)
        ins === :inp && (i+=1)
        run(alu, model_number[i])
    end
    return alu.z, alu.y, alu.x, alu.w
end

# foreach(println, [d for d in data if d[1] === :inp || d[2] === :z])
# (:div, :z, 26)
# (:mul, :z, :y)
# (:add, :z, :y)
maxz = Dict(
    14 => 13,
    13 => 14*26,
    12 => 14*26^2,
    11 => 14*26,
    10 => 14*26^2,
    9  => 14*26^3,
    8  => 14*26^2,
    7  => 14*26,
    6  => 14*26^2,
    5  => 14*26^3,
    4  => 14*26^2,
    3  => 14*26^1,
    2  => 14,
    1  => 14,
)

function solve(x, n, func)
    alu = ALU(x)
    checkpoint = Dict{Int, ALU}()
    model_number = fill(n, 14)
    i = 0
    #while true
    for _ in 1:10_000_000
        ok = true
        while !isempty(alu.program)
            ins, args... = instruction(alu)
            if ins == :inp
                if alu.z > maxz[i+1]
                    ok = false
                    break
                end
                checkpoint[i] = copy(alu)
                i += 1
                run(alu, model_number[i])
            elseif (
                (ins === :div && value(alu, last(args)) == 0)
                || (ins === :mod && (value(alu, first(args)) < 0 || value(alu, last(args)) <= 0))
            )
                ok = false
                @warn "bad input"
                break
            else
                run(alu, model_number[i])
            end
        end
        ok && alu.z == 0 && return model_number |> join |> toint
        model_number, i = func(model_number, i)
        alu = checkpoint[i]
    end
    return model_number, alu.z
end

solve1(x) = solve(x, 6, decrease)


###
### Part 2
###

function increase(model_number, i)
    model_number = copy(model_number)
    model_number[i+1:end] .= 1
    model_number[i] += 1
    return model_number[i] == 10 ? increase(model_number, i-1) : (model_number, i-1)
end

solve2(x) = solve(x, 1, increase)

end  # module
