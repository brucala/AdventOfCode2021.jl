module test_day6

using Test
using AdventOfCode2021.Day6

nday = 6

data = parse_input(nday)

test = parse_input("3,4,3,1,2")

@testset "Day$nday tests" begin
    @test solve1(test) == 5934
    @test solve2(test) == 26984457539
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 366057
    @test solve2(data) == 1653559299811
end

end  # module
