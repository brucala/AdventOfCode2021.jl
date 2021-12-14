module test_day14

using Test
using AdventOfCode2021.Day14

nday = 14

data = parse_input(nday)

test = parse_input(
"""
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 1588
    @test solve2(test) == 2188189693529
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 3048
    @test solve2(data) == 3288891573057
end

end  # module
