module test_day5

using Test
using AdventOfCode2021.Day5

nday = 5

data = parse_input(nday)

test = parse_input(
"""
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 5
    @test solve2(test) == 12
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 5145
    @test solve2(data) == 16518
end

end  # module
