module test_day1

using Test
using AdventOfCode2021.Day1

nday = 1

data = parse_input(nday)

test = parse_input(
"""
199
200
208
210
200
207
240
269
260
263
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 7
    @test solve2(test) == 5
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 1692
    @test solve2(data) == 1724
end

end  # module
