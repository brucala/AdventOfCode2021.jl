module Day4
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    numbers, boards... = split(strip(x), "\n\n")
    numbers = split(numbers, ",") .|> toint
    boards = getgrid.(boards, fmap=toint, sep=" ")
    return numbers, boards
end

###
### Part 1
###

struct Bingo
    numbers::Vector{Int}
    boards::Vector{Matrix{Int}}
    iboards::Vector{Matrix{Int}}
end
function Bingo(numbers, boards)
    iboards = map(b->iboard(b, numbers), boards)
    Bingo(numbers, boards, iboards)
end
iboard(board::Matrix{Int}, numbers::Vector{Int}) = map(i->findfirst(isequal(i), numbers), board)

function winsat(b::Bingo, i)
    iboard = b.iboards[i]
    min1, _ = findmin(maximum(iboard, dims=1))
    min2, _ = findmin(maximum(iboard, dims=2))
    return min(min1, min2)
end

function score(b::Bingo, i, n)
    lastnumber = b.numbers[n]
    board = b.boards[i]
    mask = board .∉ (b.numbers[1:n],)
    boardsum = sum(board[mask])
    return lastnumber * boardsum
end

function winner_score(b::Bingo)
    iwinner, nwinner = 0, length(b.numbers) + 1
    for i in 1:length(b.boards)
        n = winsat(b, i)
        if n < nwinner
            iwinner, nwinner = i, n
        end
    end
    return score(b, iwinner, nwinner)
end

function solve1(x)
    numbers, boards = x
    bingo = Bingo(numbers, boards)
    return winner_score(bingo)
end

###
### Part 2
###

function loser_score(b::Bingo)
    iloser, nloser = 0, 0
    for i in 1:length(b.boards)
        n = winsat(b, i)
        if n > nloser
            iloser, nloser = i, n
        end
    end
    return score(b, iloser, nloser)
end

function solve2(x)
    numbers, boards = x
    bingo = Bingo(numbers, boards)
    return loser_score(bingo)
end

end  # module
