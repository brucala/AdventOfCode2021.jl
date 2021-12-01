using Test
using AdventOfCode2021

@testset "AdventOfCode2021 tests" begin
     for day in solved_days
        @testset "Day $day" begin include("test_day$day.jl") end
     end
end
