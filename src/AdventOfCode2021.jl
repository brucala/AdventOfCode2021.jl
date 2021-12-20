module AdventOfCode2021

# day 19 is very slow
solved_days = vcat(1:18, 20:20)

for day = solved_days
    include("day$day.jl")
end

include("utils.jl")

export solved_days

end # module
