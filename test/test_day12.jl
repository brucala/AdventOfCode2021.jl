module test_day12

using Test
using AdventOfCode2021.Day12

nday = 12

data = parse_input(nday)

test1 = parse_input(
"""
start-A
start-b
A-c
A-b
b-d
A-end
b-end
"""
)

test2 = parse_input(
"""
dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc
"""
)

test3 = parse_input(
"""
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
"""
)

@testset "Day$nday tests" begin
    @test solve1(test1) == 10
    @test solve1(test2) == 19
    @test solve1(test3) == 226
    @test solve2(test1) == 36
    @test solve2(test2) == 103
    @test solve2(test3) == 3509
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 4912
    @test solve2(data) == 150004
end

end  # module
