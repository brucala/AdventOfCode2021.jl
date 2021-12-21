module test_day21

using Test
using AdventOfCode2021.Day21

nday = 21

data = parse_input(nday)

test = parse_input(
"""
Player 1 starting position: 4
Player 2 starting position: 8
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 739785
    @test solve2(test) == 444356092776315
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 506466
    @test solve2(data) == 632979211251440
end

end  # module
