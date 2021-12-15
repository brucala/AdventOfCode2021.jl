module test_day15

using Test
using AdventOfCode2021.Day15

nday = 15

data = parse_input(nday)

test = parse_input(
"""
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 40
    @test solve2(test) == 315
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 435
    @test solve2(data) == 2842
end

end  # module
