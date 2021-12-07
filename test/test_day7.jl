module test_day7

using Test
using AdventOfCode2021.Day7

nday = 7

data = parse_input(nday)

test = parse_input("16,1,2,0,4,2,7,1,2,14")

@testset "Day$nday tests" begin
    @test solve1(test) == 37
    @test solve2(test) == 168
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 348664
    @test solve2(data) == 100220525
end

end  # module
