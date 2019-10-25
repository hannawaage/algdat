#=
bactrack:
- Julia version: 1.2.0
- Author: hannahjelmeland
- Date: 2019-10-17
=#
### Du skal implementere denne funksjonen ###

function backtrack(pathweights)
    r, c = size(pathweights)
    p = [(0, 0) for i in 1:r]
    q = typemax(Int64)
    for j = 1:c
        if pathweights[r, j] < q
            q = pathweights[r, j]
            p[1] = (r, j)
        end
    end
    for i = r - 1:-1:1
        q = typemax(Int64)
        ind = [p[r - i][2] - 1, p[r - i][2], p[r - i][2] + 1]
        ind = [i for i in ind if (i > 0 && i < c + 1)]
        for j = 1:length(ind)
            if pathweights[i, ind[j]] < q
                q = pathweights[i, ind[j]]
                p[r - i + 1] = (i, ind[j])
            end
        end
    end
    return p
end

#=
[3  6  8  6  3;
10 9  11 10 6;
13 19 13 7  12;
23 17 10 8  9;
23 11 15 11 17]) == [(5,2), (4,3), (3,4), (2,5), (1,5)] =#


### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!
printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test backtrack([1 1 ; 2 2]) == [(2,1),(1,1)]
    #Dette er samme eksempel som det vist i oppgaveteskten
	@test backtrack([3  6  8  6  3; 10 9  11 10 6; 13 19 13 7  12; 23 17 10 8  9; 23 11 15 11 17]) == [(5,2), (4,3), (3,4), (2,5), (1,5)]
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
