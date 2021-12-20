module test_day19

using Test
using AdventOfCode2021.Day19

nday = 19

data = parse_input(nday)

test = parse_example(nday)

@testset "Day$nday tests" begin
    @test solve1(test) == 79
    @test solve2(test) == 3621
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 496
    @test solve2(data) == 14478
end

end  # module
