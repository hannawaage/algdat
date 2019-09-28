#=
doubly_linked:
- Julia version: 1.2.0
- Author: hannahjelmeland
- Date: 2019-09-28
=#

mutable struct NodeDoublyLinked
    prev::Union{NodeDoublyLinked, Nothing} # Er enten forrige node eller nothing
    next::Union{NodeDoublyLinked, Nothing} # Er enten neste node eller nothing
    value::Int # Verdien til noden
end

function createLinkedListDoublyLinked(length)
    # Create the list from the last element in the chain
    # This is so the returned element will be the first in the chain
    current = nothing
    beforeCurrent = nothing

    for i in 1:length
        # only fill out the next field because prev will be filled out later
        current = NodeDoublyLinked(nothing, beforeCurrent, rand(-100:100))
        # link up the node before this node to this node
        if beforeCurrent != nothing
            beforeCurrent.prev = current
        end
        beforeCurrent = current
    end
    return current
end



# Importing the struct beeing used
# Inside a try-catch to allow it to be defined multiple times
# (Mostly a workaround for some IDEs, you don't have to care about this)
try
    mutable struct NodeDoublyLinked
        prev::Union{NodeDoublyLinked, Nothing} # Er enten forrige node eller nothing
        next::Union{NodeDoublyLinked, Nothing} # Er enten neste node eller nothing
        value::Int # Verdien til noden
    end
catch e end




## Du skal implementere denne funksjonen
function maxofdoublelinkedlist(linkedlist)
    node = linkedlist
    max = 0
    if node.value > max
        max = node.value
    end
    while node.next != nothing
        if node.next.value > max
            max = node.next.value
        end
        node = node.next
    end
    while node.prev != nothing
        if node.prev.value > max
            max = node.prev.value
        end
        node = node.prev
    end

    return max
end

### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

## Simple doubly linked chain
# Generated from the tail of the list
#                     prev     next     value
n3 = NodeDoublyLinked(nothing, nothing, 100)
n2 = NodeDoublyLinked(nothing, n3, 10)
n1 = NodeDoublyLinked(nothing, n2, 1)
n0 = NodeDoublyLinked(nothing, n1, 200)
n3.prev = n2
n2.prev = n1
n1.prev = n0

using Test
printstyled("\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)
@testset "Basic tests" begin
    @test maxofdoublelinkedlist(n1) == 200
    @test maxofdoublelinkedlist(n2) == 200
    @test maxofdoublelinkedlist(n3) == 200
    @test maxofdoublelinkedlist(n0) == 200
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n\n\n")
