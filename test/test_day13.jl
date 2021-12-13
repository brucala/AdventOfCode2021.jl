module test_day13

using Test
using AdventOfCode2021.Day13

nday = 13

data = parse_input(nday)

test = parse_input(
"""
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 17
    #@test solve2(test) == "O"
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 745
    #@test solve2(data) == "ABKJFBGC"
end

end  # module
