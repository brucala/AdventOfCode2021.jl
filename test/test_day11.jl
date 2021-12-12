module test_day11

using Test
using AdventOfCode2021.Day11

nday = 11

data = parse_input(nday)

test = parse_input(
"""
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 1656
    @test solve2(test) == 195
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 1617
    @test solve2(data) == 258
end

end  # module
