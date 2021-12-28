module test_day24

using Test
using AdventOfCode2021.Day24

nday = 24

data = parse_input(nday)

test = parse_input(
"""
inp w
add z w
mod z 2
div w 2
add y w
mod y 2
div w 2
add x w
mod x 2
div w 2
mod w 2
"""
)

#@testset "Day$nday tests" begin
#    @test solve1(test) == ?
    #@test solve2(test) == ?
#end

@testset "Day$nday solutions" begin
    @test solve1(data) == 59998426997979
    @test solve2(data) == 13621111481315
end

end  # module
