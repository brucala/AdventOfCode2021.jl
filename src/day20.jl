module Day20
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    blocks = split(strip(x), "\n\n")
    @assert length(blocks) == 2
    algo = map(==('#'), collect(replace(blocks[1], "\n"=> "")))
    image = BitMatrix(getgrid(blocks[2], fmap= ==('#')))
    return BitVector(algo), BitArray(image)
end

###
### Part 1
###

function borders(x, padvalue)
    n, m = size(x)
    b1, b2 = [0,0], [0,0]
    for i in 1:n
        v = padvalue ? x[i,:] : .!x[i,:]
        all(v) && continue
        b1[1] = i
        break
    end
    for i in n:-1:1
        v = padvalue ? x[i,:] : .!x[i,:]
        all(v) && continue
        b1[2] = i
        break
    end
    for i in 1:m
        v = padvalue ? x[:,i] : .!x[:,i]
        all(v) && continue
        b2[1] = i
        break
    end
    for i in m:-1:1
        v = padvalue ? x[:,i] : .!x[:,i]
        all(v) && continue
        b2[2] = i
        break
    end
    @assert all(!=(0), vcat(b1, b2))
    return UnitRange(b1...), UnitRange(b2...)
end

function stripborders(x, padvalue)
    b1, b2 = borders(x, padvalue)
    return x[b1, b2]
end

function pad(x, padvalue=false)
    image = stripborders(x, padvalue)
    n, m = size(image)
    N, M = n + 4, m + 4
    padimage = padvalue ? trues(N,M) : falses(N, M)
    padimage[3:end-2, 3:end-2] = image
    return padimage
end

bin2dec(x) = sum(2^(length(x) - i) * b for (i, b) in enumerate(x))

function enhance(x, algo, padvalue)
    image = pad(x, padvalue)
    n, m = size(image)
    enhanced = copy(image)
    for i in 2:n-1, j in 2:m-1
        n = vec(view(image, i-1:i+1, j-1:j+1)')
        n = bin2dec(n)
        enhanced[i, j] = algo[n+1]
    end
    return stripborders(enhanced, padvalue)
end

function imshow(image)
    n, m = size(image)
    for i in 1:n
        for j in 1:m
            print(image[i,j] ? "o" : " ")
        end
        println()
    end
end

function solve(x, n)
    algo, image = x
    for i in 1:n
        padvalue = algo[1] && !isodd(i)
        image = enhance(image, algo, padvalue)
        #imshow(image)
    end
    #imshow(image)
    return sum(image)
end

solve1(x) = solve(x, 2)

###
### Part 2
###

solve2(x) = solve(x, 50)

end  # module
