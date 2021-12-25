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

isoccupied(state, type) = haskey(state, (TARGET[type], 2)) || (haskey(state, (TARGET[type], 3)) && state[(TARGET[type], 3)] != type)

ishomeblocked(state, type::Char, i::Int) = isoccupied(state, type) || isblocked(state, i, TARGET[type])
#isblocked(state, i1, i2) = any(i -> haskey(state, (i, 1)), min(i1, i2)+1:max(i1, i2)-1)
isblocked(state, pos::NTuple{2, Int}) = pos[2] == 3 && haskey(state, (pos[1], 2))
function isblocked(state, i1::Int, i2::Int)
    taken = taken_corridor(state)
    return i2 in taken || any(in(taken), min(i1, i2)+1:max(i1, i2)-1)
end

taken_corridor(state) = Int[i for (i, j) in keys(state) if j == 1 && i in ICORRIDOR]
available_corridor(state) = setdiff(ICORRIDOR, taken_corridor(state))

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
    jtarget = haskey(state, (itarget, 3)) ? 2 : 3
    newpos = (itarget, jtarget)
    return totarget(state, pos, newpos, energy)
end
function tocorridor(state, pos, icorridor, energy)
    newpos = (icorridor, 1)
    return totarget(state, pos, newpos, energy)
end

add!(queue, state, energy) = (!haskey(queue, state) || queue[state] > energy) && (queue[state] = energy)

function update!(queue, state, energy)
    for (pos, type) in state
        (i, j) = pos
        j == 3 && ishome(type, i) && continue
        j == 2 && ishome(type, i) && haskey(state, (TARGET[type], 3)) && state[(TARGET[type], 3)] == type && continue
        isblocked(state, pos) && continue
        if !iscorridor(j)
            for icorridor in available_corridor(state)
                #isblocked(state, i, icorridor) || println("adding to queu: $pos -> corridor $icorridor")
                isblocked(state, i, icorridor) || add!(queue, tocorridor(state, pos, icorridor, energy)...)
            end
        end
        #ishomeblocked(state, type, i) || println("adding to queu: $pos -> home")
        ishomeblocked(state, type, i) || add!(queue, tohome(state, pos, energy)...)
    end
end

#function update!(queue, state, energy)
#    for anphipod in state
#        (i, j), type = anphipod
#        itarget = TARGET[type]
#        i == itarget && continue
#        if j == 1
#            isblocked(state, i, itarget) && continue
#            jtarget = 3
#            if haskey(state, (itarget, 3))
#                state[(itarget, 3)] == type || continue
#                jtarget = 2
#            end
#            newstate = move(state, (i, j), (itarget, jtarget))
#            e = sum(abs, (itarget, jtarget) .- (i, j)) * ENERGY[type]
#            (!haskey(queue, newstate) || queue[newstate] > energy+e) && (queue[newstate] = energy + e)
#        else
#            j == 3 && haskey(state, (i, 2)) && continue
#            if !haskey(state, (itarget, 3)) || state[(itarget, 2)] == type
#                if !isblocked(state, i, itarget)
#                    jtarget = haskey(state, (itarget, 3)) ? 2 : 3
#                    newstate = move(state, (i, j), (itarget, jtarget))
#                    e = (sum(abs, (itarget, jtarget) .- (i, 1)) + j-1) * ENERGY[type]
#                    (!haskey(queue, newstate) || queue[newstate] > energy+e) && (queue[newstate] = energy + e)
#                end
#            end
#            for itarget in (1, 2, 4, 6, 8, 10, 11)
#                if !isblocked(state, i, itarget)
#                    jtarget = 1
#                    newstate = move(state, (i, j), (itarget, jtarget))
#                    e = (sum(abs, (itarget, jtarget) .- (i, 1)) + j-1) * ENERGY[type]
#                    (!haskey(queue, newstate) || queue[newstate] > energy+e) && (queue[newstate] = energy + e)
#                end
#            end
#        end
#    end
#end


function solve1(state)
    energy = 0
    minenergy = typemax(Int)
    seen = Dict{typeof(state) ,Int}()
    queue = PriorityQueue(state => 0)
    while !isempty(queue)
        state, energy = dequeue_pair!(queue)
        energy >= minenergy && continue
        haskey(seen, state) && seen[state] < energy && continue
        seen[state] = energy
        state == TARGET_STATE && (minenergy = min(minenergy, energy))
        update!(queue, state, energy)
    end
    #return seen
    return minenergy
end

###
### Part 2
###

function solve2(x)

end

end  # module
