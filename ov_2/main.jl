#=
main:
- Julia version: 
- Author: hannahjelmeland
- Date: 2019-09-28
=#

mutable struct Node
    next::Union{Node, Nothing} # next kan peke på et Node-objekt eller ha verdien nothing.
    value::Int
end

function createlinkedlist(length)
    # Creates the list starting from the last element
    # This is done so the last element we generate is the head
    child = nothing
    node = nothing

    for i in 1:length
        node = Node(child, rand(1:800))
        child = node
    end
    return node
end

function reverseandlimit(array, maxnumber)
    n = length(array)
    temp = []
    for i = 1:n
        j = n + 1 - i
        if array[j] > maxnumber
            push!(temp, maxnumber)
        else
            push!(temp, array[j])
        end
    end
    return temp
end

# Importing the struct beeing used
# Inside a try-catch to allow it to be defined multiple times
# (Mostly a workaround for some IDEs, you don't have to care about this)
try
    mutable struct Node
        next::Union{Node, Nothing} # Next can be a new Node or nothing
        value::Int
    end
catch e end




## Du skal implementere denne funksjonen
function findindexinlist(linkedlist, index)
    node = linkedlist
    if index == 1
        return node.value
    end
    for i in 1:index - 1
        if node.next == nothing
            return -1
        end
        node = node.next
    end
    return node.value
end



### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

## Simple linked chain
n3 = Node(nothing, 100)
n2 = Node(n3, 10)
n1 = Node(n2, 1)

using Test
printstyled("\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)
@testset "Basic tests" begin
    @test findindexinlist(n1, 1) == 1
    @test findindexinlist(n1, 2) == 10
    @test findindexinlist(n1, 3) == 100
    @test findindexinlist(n1, 4) == -1
    @test findindexinlist(n1, 50) == -1
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n\n\n")

