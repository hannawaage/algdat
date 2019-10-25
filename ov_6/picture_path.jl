#=
picture_path:
- Julia version: 1.2.0
- Author: hannahjelmeland
- Date: 2019-10-17
=#
### Du skal implementere denne funksjonen ###
function cumulative(weights)
    r, c = size(weights)
    m = zeros(Int32, r, c)
    m[1, :] = weights[1, :]
    for i = 2:r
        for j = 1:c
            if j == 1 || j == c
                if j == 1
                    m[i, j] = min(m[i - 1, j], m[i - 1, j + 1]) + weights[i, j]
                else
                    m[i, j] = min(m[i - 1, j], m[i - 1, j - 1]) + weights[i, j]
                end
            else
                m[i, j] = min(m[i - 1, j], m[i - 1, j + 1], m[i - 1, j - 1]) + weights[i, j]
            end
        end
    end
    return m
end

### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test cumulative([1 1 ; 1 1]) == [1 1 ;2 2]
    #Dette er samme eksempel som det vist i oppgaveteskten
	@test cumulative([3  6  8 6 3; 7  6  5 7 3; 4  10 4 1 6; 10 4  3 1 2;6  1  7 3 9])== [3  6  8  6  3;10 9  11 10 6;13 19 13 7  12;23 17 10 8  9;23 11 15 11 17]
end


println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")