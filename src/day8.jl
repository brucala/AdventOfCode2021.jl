module Day8
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

sets(x::AbstractString) = Set.(split(x))
parse_input(x::AbstractString) = [sets.(split(line, "|")) for line in splitlines(x)]


###
### Part 1
###

count1478(x) = count(∈([2,3,4,7]), length.(x))
solve1(x) = sum(i -> count1478(i[2]), x)

###
### Part 2
###

function find9!(signal, dict, segments)
    s = dict[4] ∪ segments[:t]
    for i in signal
        length(i) == 6 || continue
        d = setdiff(i, s)
        length(d) == 1 || continue
        dict[9] = i
        segments[:b] = d |> first
        segments[:bl] = setdiff(dict[8], i) |> first
        return
    end
    return @warn("shouldn't get here")
end
function find6!(signal, dict, segments)
    for i in signal
        (length(i) == 6 && i != dict[9]) || continue
        d = setdiff(dict[1], i)
        length(d) == 1 || continue
        dict[6] = i
        segments[:tr] = d |> first
        segments[:br] = setdiff(dict[1], d) |> first
        return
    end
    return @warn("shouldn't get here")
end
function find0!(signal, dict, segments)
    for i in signal
        (length(i) == 6 && i != dict[9] && i != dict[6]) || continue
        dict[0] = i
        segments[:m] = setdiff(dict[8], i) |> first
        segments[:tl] = setdiff(i, values(segments)) |> first
        return
    end
    return @warn("shouldn't get here")
end

function decode(x)
    signal, out = x
    signal = Set(signal) ∪ Set(out) |> collect
    lens = length.(signal)
    dict = Dict{Int, Set{Char}}()
    dict[1] = signal[findfirst(==(2), lens)]
    dict[7] = signal[findfirst(==(3), lens)]
    dict[4] = signal[findfirst(==(4), lens)]
    dict[8] = signal[findfirst(==(7), lens)]
    segments = Dict{Symbol, Char}()
    segments[:t] = setdiff(dict[7], dict[1]) |> first
    find9!(signal, dict, segments)
    find6!(signal, dict, segments)
    find0!(signal, dict, segments)
    dict[2] = Set(segments[i] for i in [:t, :tr, :m, :bl, :b])
    dict[3] = Set(segments[i] for i in [:t, :tr, :m, :br, :b])
    dict[5] = Set(segments[i] for i in [:t, :tl, :m, :br, :b])
    invdict = Dict(v=>k for (k,v) in dict)
    join([invdict[i] for i in out]) |> toint
end

solve2(x) = sum(decode, x)

end  # module
