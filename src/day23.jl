module Day23
include("utils.jl")
using .Utils
import .Utils: parse_input
using DataStructures

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    lines = splitlines(x)
    slots = [(i, j) for i in (3, 5, 7, 9), j in (2, 3)]
    state = Dict{NTuple{2, Int}, Char}()
    for slot in slots
        i, j = slot
        state[slot] = lines[j+1][i+1]
    end
    return state
end

###
### Part 1
###

const TARGET_STATE = Dict(
    (3, 2) => 'A',
    (3, 3) => 'A',
    (5, 2) => 'B',
    (5, 3) => 'B',
    (7, 2) => 'C',
    (7, 3) => 'C',
    (9, 2) => 'D',
    (9, 3) => 'D',
)

const TARGET = Dict(
    'A' => 3,
    'B' => 5,
    'C' => 7,
    'D' => 9,
)
const ENERGY = Dict(
    'A' => 1,
    'B' => 10,
    'C' => 100,
    'D' => 1000,
)

const ICORRIDOR = [1, 2, 4, 6, 8, 10, 11]

ishome(type, i) = TARGET[type] == i
iscorridor(j) = j == 1

move(state, pos, newpos) = Dict(
    (k == pos ? newpos : k) => v
    for (k, v) in state
)

function ishomeoccupied(state, type)
    i = TARGET[type]
    return any(state[(i, j)]!=type for j in jtaken(state, i))
end

ishomeblocked(state, type::Char, i::Int) = ishomeoccupied(state, type) || isblocked(state, i, TARGET[type])
isblocked(state, pos::NTuple{2, Int}) = any(j < pos[2] for j in jtaken(state, pos[1]))
function isblocked(state, i1::Int, i2::Int)
    taken = taken_corridor(state)
    return i2 in taken || any(in(taken), min(i1, i2)+1:max(i1, i2)-1)
end

taken_corridor(state) = Int[i for (i, j) in keys(state) if j == 1 && i in ICORRIDOR]
available_corridor(state) = setdiff(ICORRIDOR, taken_corridor(state))

jtaken(state, itarget) = Int[j for (i, j) in keys(state) if i == itarget]

function Δe(type, pos, newpos)
    e = abs(pos[1] - newpos[1]) # horizontal
    e += newpos[2] + pos[2] - 2 # vertical
    return e * ENERGY[type]
end
function totarget(state, pos, newpos, energy)
    newstate = move(state, pos, newpos)
    newenergy = energy + Δe(state[pos], pos, newpos)
    return newstate, newenergy
end
function tohome(state, pos, energy)
    itarget = TARGET[state[pos]]
    taken = jtaken(state, itarget)
    jtarget = isempty(taken) ? len(state) : minimum(taken) - 1
    newpos = (itarget, jtarget)
    return totarget(state, pos, newpos, energy)
end
function tocorridor(state, pos, icorridor, energy)
    newpos = (icorridor, 1)
    return totarget(state, pos, newpos, energy)
end

len(state) = maximum(last, keys(state))

add!(queue, state, energy) = (!haskey(queue, state) || queue[state] > energy) && (queue[state] = energy)

function update!(queue, state, energy)
    for (pos, type) in state
        (i, j) = pos
        ishome(type, i) && !ishomeoccupied(state, type) && continue
        isblocked(state, pos) && continue
        if !iscorridor(j)
            for icorridor in available_corridor(state)
                isblocked(state, i, icorridor) || add!(queue, tocorridor(state, pos, icorridor, energy)...)
            end
        end
        ishomeblocked(state, type, i) || add!(queue, tohome(state, pos, energy)...)
    end
end

function solve(state, target=TARGET_STATE)
    energy = 0
    minenergy = typemax(Int)
    #seen = Dict{typeof(state) ,Int}()
    queue = PriorityQueue(state => 0)
    while !isempty(queue)
        state, energy = dequeue_pair!(queue)
        energy >= minenergy && continue
        #haskey(seen, state) && seen[state] < energy && continue
        #seen[state] = energy
        state == target && (minenergy = min(minenergy, energy))
        update!(queue, state, energy)
    end
    return minenergy
end

solve1(state) = solve(state)

###
### Part 2
###

const TARGET_STATE2 = Dict(
    (i, j) => v
    for (v, i) in TARGET, j in 2:5
)

function unfold(state)
    for (i, v3, v4) in zip((3, 5, 7, 9), "DCBA", "DBAC")
        state = move(state, (i,3), (i,5))
        state[(i, 3)] = v3
        state[(i, 4)] = v4
    end
    return state
end

solve2(state) = solve(unfold(state), TARGET_STATE2)

end  # module
