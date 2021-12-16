module test_day16

using Test
using AdventOfCode2021.Day16
using AdventOfCode2021.Day16: decode, version, versions, type_id, value

nday = 16

data = parse_input(nday)

@testset "Day$nday tests" begin
    p1 = decode("D2FE28")
    @test version(p1) == 6
    @test type_id(p1) == 4
    @test value(p1) == 2021
    p2 = decode("38006F45291200")
    @test version(p2) == 1
    @test type_id(p2) == 6
    @test value(p2.packet.subpackets[1]) == 10
    @test value(p2.packet.subpackets[2]) == 20
    p3 = decode("EE00D40C823060")
    @test version(p3) == 7
    @test type_id(p3) == 3
    @test value(p3.packet.subpackets[1]) == 1
    @test value(p3.packet.subpackets[2]) == 2
    @test value(p3.packet.subpackets[3]) == 3
    @test solve1("8A004A801A8002F478") == 16
    @test solve1("620080001611562C8802118E34") == 12
    @test solve1("C0015000016115A2E0802F182340") == 23
    @test solve1("A0016C880162017C3686B18A3D4780") == 31
    @test solve2("C200B40A82") == 3
    @test solve2("CE00C43D881120") == 9
    @test solve2("9C0141080250320F1802104A08") == 1
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 993
    @test solve2(data) == 144595909277
end

end  # module
