module test_day10

using Test
using AdventOfCode2021.Day10

nday = 10

data = parse_input(nday)

test = parse_input(
"""
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 26397
    @test solve2(test) == 288957
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 394647
    @test solve2(data) == 2380061249
end

end  # module
