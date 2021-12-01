module Utils

export read_input, parse_input, parse_ints, toint, splitlines, stripspaces, getgrid, find

function read_input(file::AbstractString)
    paths = ["data/" "../data/"]
    for filepath in joinpath.(paths, file)
        if isfile(filepath)
            return readchomp(filepath) |> String
        end
    end
    error("input $file not found in $paths")
end
read_input(iday::Int) = read_input("input$iday.txt")

parse_input(iday::Int) = read_input(iday) |> parse_input

"Parse each line assuming it's an integer."
parse_ints(x::AbstractString) = readlines(IOBuffer(x)) .|> toint

toint(s::Union{AbstractString, Char}) = parse(Int, s)

splitlines(s::AbstractString) = split(s, '\n')

stripspaces(s::AbstractString) = replace(s, " " => "")

getgrid(s::AbstractString, fmap=identity) = getgrid(splitlines(rstrip(s, '\n')), fmap)
function getgrid(lines::Vector{T}, fmap=identity) where T <: AbstractString
    n, m = length(lines), length(first(lines))
    grid = map(fmap, Iterators.flatten(lines))
    return reshape(grid, (m,n)) |> permutedims  # so it's well oriented
end

"""
    find(collection, element)

Finds index of first occurrence of element `a` in collection `A`.
"""
find(A, a) = findfirst(==(a), A)

end
