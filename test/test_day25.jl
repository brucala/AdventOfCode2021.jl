module test_day25

using Test
using AdventOfCode2021.Day25

nday = 25

data = parse_input(nday)

test = parse_input(
"""
v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 58
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 406
end

end  # module
