module AdventOfCode2021

solved_days = 1:3

for day = solved_days
    include("day$day.jl")
end

include("utils.jl")

export solved_days

end # module