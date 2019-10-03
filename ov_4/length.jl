#=
length:
- Julia version: 1.2.0
- Author: hannahjelmeland
- Date: 2019-10-03
=#

function countingsortlength(A)
    n = length(A)

    dig = Array{Int32}(undef, 0)
    C = Array{Int32}(undef, 0)
	B =  Array{String}(undef, n)

    for i = 1:n
		a = length(A[i])
		dig = [dig; a]
    end

    C = [0]
    for i = 1:n
		l = length(C)
		if l < (dig[i] + 1)
			for j = l:dig[i] + 1
				C = [C; 0]
			end
		end
        C[dig[i] + 1] = C[dig[i] + 1] + 1
    end

    k = length(C)
    for i = 2:k
        C[i] = C[i] + C[i-1]
    end

    for j = n:-1:1
        B[C[length(A[j]) + 1]] = A[j];
        C[dig[j] + 1] = C[dig[j] + 1] - 1;
    end
	return B
end





### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Basic tests" begin
    @test countingsortlength(["ccc", "bb", "a"]) == ["a", "bb", "ccc"]
    @test countingsortlength(["aaa", "bb", "c"]) == ["c", "bb", "aaa"]
    @test countingsortlength(["bb", "a", ""]) == ["", "a", "bb"] # Testen her sjekker om du kan sortere også med emtpy string
    @test countingsortlength(["bbbb", "aa", "aaaa", "ccc"]) == ["aa", "ccc", "bbbb", "aaaa"] # Fra oppgaven
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")