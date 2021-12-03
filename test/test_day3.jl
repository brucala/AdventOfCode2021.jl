module test_day3

using Test
using AdventOfCode2021.Day3

nday = 3

data = parse_input(nday)

test = Day3.parse_input(
"""
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 198
    @test solve2(test) == 230
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 749376
    @test solve2(data) == 2372923
end

end  # module
