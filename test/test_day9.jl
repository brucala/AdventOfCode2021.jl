module test_day9

using Test
using AdventOfCode2021.Day9

nday = 9

data = parse_input(nday)

test = parse_input(
"""
2199943210
3987894921
9856789892
8767896789
9899965678
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 15
    @test solve2(test) == 1134
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 500
    @test solve2(data) == 970200
end

end  # module
