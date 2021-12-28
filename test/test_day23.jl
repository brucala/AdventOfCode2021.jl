module test_day23

using Test
using AdventOfCode2021.Day23

nday = 23

data = parse_input(nday)

test = parse_input(
"""
#############
#...........#
###B#C#B#D###
  #A#D#C#A#
  #########
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 12521
    @test solve2(test) == 44169
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 12530
    @test solve2(data) == 50492
end

end  # module
