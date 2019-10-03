#=
main:
- Julia version: 1.2.0
- Author: hannahjelmeland
- Date: 2019-10-02
=#

function countingsortletters(A, position)
	n = length(A)

    dig = Array{Int32}(undef, 0)
    C = Array{Int32}(undef, 0)
	B =  Array{String}(undef, n)

    for i = 1:n
		a = A[i][position]
		dig = [dig; chartodigit(a)]
    end

    for i = 1:n
		l = length(C)
		if l < dig[i]
			for j = l:dig[i]
				C = [C; 0]
			end
		end
        C[dig[i]] = C[dig[i]] + 1
    end

    k = length(C)
    for i = 2:k
        C[i] = C[i] + C[i-1]
    end

    for j = n:-1:1
        B[C[chartodigit(A[j][position])]] = A[j];
        C[dig[j]] = C[dig[j]] - 1;
    end
	return B
end


# Don't mind me
function chartodigit(character)
    #Dette er en hjelpefunksjon for å få omgjort en char til tall
    #Den konverterer 'a' til 1, 'b' til 2 osv.
    #Eksempel: chartodigit("hei"[2]) gir 5 siden 'e' er den femte bokstaven i alfabetet.
    return character - '`'
end



### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!


printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Basic tests" begin
    @test countingsortletters(["aa", "bb", "cc"], 1) == ["aa", "bb", "cc"]
    @test countingsortletters(["cc", "bb", "aa"], 2) == ["aa", "bb", "cc"]
    @test countingsortletters(["ac", "bb", "ca"], 2) == ["ca", "bb", "ac"]
    @test countingsortletters(["ccc", "cba", "ca", "ab", "abc"], 2) == ["ca", "cba", "ab", "abc", "ccc"]
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
