module test_day17

using Test
using AdventOfCode2021.Day17

nday = 17

data = parse_input(nday)

test = parse_input("target area: x=20..30, y=-10..-5")

@testset "Day$nday tests" begin
    @test solve1(test) == 45
    @test solve2(test) == 112
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 5460
    @test solve2(data) == 3618
end

end  # module
