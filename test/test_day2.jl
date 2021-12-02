module test_day2

using Test
using AdventOfCode2021.Day2

nday = 2

data = parse_input(nday)

test = parse_input(
"""
forward 5
down 5
forward 8
up 3
down 8
forward 2
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 150
    @test solve2(test) == 900
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 2322630
    @test solve2(data) == 2105273490
end

end  # module
