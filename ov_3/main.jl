#=
main:
- Julia version: 1.2.0
- Author: hannahjelmeland
- Date: 2019-09-28
=#
function mergearrays(x, y, coordinate)
    merged = Array{Int32}(undef, 0, 2)

    x = [x; [typemax(Int32) typemax(Int32)]]
    y = [y; [typemax(Int32) typemax(Int32)]] #sentinels

    n_1 = size(x, 1)
    n_2 = size(y, 1)

    i = 1
    j = 1

    while i < n_1 || j < n_2
        if y[j, coordinate] < x[i, coordinate]
            merged = [merged; y[j,1] y[j,2]]
            j += 1
        else
            merged = [merged; x[i,1] x[i,2]]
            i += 1
        end
    end
    return merged
end

function mergesort(x, coordinate)
    n = size(x, 1)
    if n == 1
        return x
    end
    l = mergesort(x[1:floor(Int, n/2), :], coordinate)
    r = mergesort(x[floor(Int, n/2) + 1:n, :], coordinate)
    sorted = mergearrays(l, r, coordinate)
    return sorted
end

function binaryintervalsearch(x, delta, coordinate)
    n = size(x, 1)
    if mod(n, 2) == 0
        med = (x[Int(n/2), coordinate] + x[Int(n/2 + 1), coordinate])/2
    else
        med = x[Int((n + 1)/2), coordinate]
    end

    min = med - delta
    max = med + delta

    #left
    p_l = 1
    mid = floor(Int, (n + 1)/2)
    r = mid

    while p_l <= r
        q = floor(Int, (p_l + r)/2)
        if x[q, coordinate] < min
            p_l = q + 1
        else
            r = q - 1
        end
    end

    if r == mid
        p_l = -1
    end

    #right
    p_r = mid
    r = n

    while p_r < r
        q = floor(Int, (p_r + r)/2)
        if x[q, coordinate] >= max
            r = q
        elseif x[q, coordinate] < max
            p_r = q + 1
        end
    end

    if p_r == mid
        p_r = -1
    end

    return p_l, p_r
end

x = [1 0; 2 0; 2 0; 3 0; 4 0; 5 0; 5 0]
delta = 1
coordinate = 1
#Dette skal gi 2, 5.

print(binaryintervalsearch(x, delta, coordinate))

x = [1 2; 2 0; 3 3; 4 4]
delta = 0.25
coordinate = 1
#Dette skal gi -1, -1.

print(binaryintervalsearch(x, delta, coordinate))