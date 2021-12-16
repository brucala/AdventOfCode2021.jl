module Day16
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = x

###
### Part 1
###

abstract type PacketType end

struct Packet{T<:PacketType}
    version::Int
    type_id::Int
    packet::T
end

version(p::Packet) = p.version
type_id(p::Packet) = p.type_id
versions(p::Packet) = append!([version(p)], versions(p.packet))

struct Literal <: PacketType
    value::Int
end

value(p::Packet{Literal}) = value(p.packet)
value(p::Literal) = p.value
versions(::Literal) = Int[]

struct Operator{T} <: PacketType
    length_type_id::Bool
    length::Int
    subpackets::Vector{Packet}
end

value(p::Packet{Operator{T}}) where T = value(p.packet)
value(p::Operator{0}) = sum(value, p.subpackets)
value(p::Operator{1}) = prod(value, p.subpackets)
value(p::Operator{2}) = minimum(value, p.subpackets)
value(p::Operator{3}) = maximum(value, p.subpackets)
function value(p::Operator{5})
    @assert length(p.subpackets) == 2
    value(p.subpackets[1]) > value(p.subpackets[2]) ? 1 : 0
end
function value(p::Operator{6})
    @assert length(p.subpackets) == 2
    value(p.subpackets[1]) < value(p.subpackets[2]) ? 1 : 0
end
function value(p::Operator{7})
    @assert length(p.subpackets) == 2
    value(p.subpackets[1]) == value(p.subpackets[2]) ? 1 : 0
end

versions(p::Operator) = vcat([versions(sp) for sp in p.subpackets]...)

PacketType(type_id::Int) = type_id == 4 ? Literal : Operator{type_id}

function consume(bits::AbstractString)
    version = parse(Int, bits[1:3], base=2)
    type_id = parse(Int, bits[4:6], base=2)
    packet, left = consume_packet(type_id, bits[7:end])
    return Packet(version, type_id, packet), left
end
consume_packet(type_id::Int, bits::AbstractString) = consume_packet(PacketType(type_id), bits)
function consume_packet(::Type{Literal}, bits::AbstractString)
    i = 1
    literal = ""
    while true
        literal *= bits[i+1:i+4]
        i += 5
        bits[i-5] == '0' && break
    end
    literal = parse(Int, literal, base=2)
    return Literal(literal), bits[i:end]
end

function consume_packet(::Type{Operator{T}}, bits::AbstractString) where T
    length_type_id = parse(Bool, bits[1])
    len, bits = consume_length(length_type_id, bits[2:end])
    subpackets = Packet[]
    left = bits
    while true
        packet, left = consume(left)
        push!(subpackets, packet)
        if length_type_id
            length(subpackets) == len && break
        else
            consumed = length(bits) - length(left)
            @assert consumed <= len
            consumed == len && break
        end
    end
    return Operator{T}(length_type_id, len, subpackets), left
end
function consume_length(length_type_id::Bool, bits)
    l = length_type_id ? 11 : 15
    return parse(Int, bits[1:l], base=2), bits[l+1:end]
end

hex2bits(s::AbstractString) = join(bitstring.(hex2bytes(s)))

function decode(hexstring::AbstractString)
    bits = hex2bits(hexstring)
    packet, left = consume(bits)
    @assert all(==('0'), left)
    return packet
end

solve1(x) = sum(versions(decode(x)))

###
### Part 2
###

solve2(x) = value(decode(x))

end  # module
