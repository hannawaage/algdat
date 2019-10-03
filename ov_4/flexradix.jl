#=
flexradix:
- Julia version: 1.2.0
- Author: hannahjelmeland
- Date: 2019-10-03

Implementer funksjonen flexradix(A, maxlength) som
sorterer strengene i A i leksikalsk rekkefølge og
returnerer et nytt array.

A er et array med strenger.
maxlength er lengden på den lengste strengen.
Du kan anta at alle strengene kun inneholder
små bokstaver mellom a og z.
Funksjonene countingsortlength og countingsortletters er
gjort tilgjengelig for deg, så selv om du ikke har gjort
de forrige oppgavene kan du løse denne.
Funksjonen skal returnere et nytt, sortert array.
Eksempel:

flexradix(["kobra", "aggie", "agg", "kort", "hyblen"], 6)
skal returnere ["agg", "aggie", "hyblen", "kobra", "kort"].
=#
## Hvis du bruker denne, kan jeg desverre ikke gi ut LF
## Da må du fylle den ut selv

function chartodigit(character)
    #Dette er en hjelpefunksjon for å få omgjort en char til tall
    #Den konverterer 'a' til 1, 'b' til 2 osv.
    #Eksempel: chartodigit("hei"[2]) gir 5 siden 'e' er den femte bokstaven i alfabetet.
    return character - '`'
end

function countingsortletters(A,position)
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

## Hvis du bruker denne, kan jeg desverre ikke gi ut LF
## Da må du fylle den ut selv
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

## Du skal implementere denne funksjonen
function flexradix(A, maxlength)
	z = 0
	B = []
	for i = 1:length(A)
		if length(A[i]) == 0
			z += 1
			continue
		end
		push!(B, A[i])
	end
    min = length(B[1])
	for i = 2:length(B)
		if length(B[i]) < min
			min = length(B[i]);
		end
	end
	for i = min:-1:1
		B = countingsortletters(B, i)
	end

	for i = 2:length(B)
		if B[i][1:min] == B[i - 1][1:min]
			B[i-1:i] = countingsortlength(B[i-1:i])
		end
	end

	for i in 1:z
		pushfirst!(B, "")
	end
	return B
end




### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Basic tests" begin
    @test flexradix(["d", "c", "b", "a"], 1) == ["a", "b", "c", "d"]
    @test flexradix(["d", "c", "b", ""], 1) == ["", "b", "c", "d"]
    @test flexradix(["jeg", "elsker", "deg"], 6) == ["deg", "elsker", "jeg"]
    @test flexradix(["denne", "oppgaven", "mangler", "emojies"], 8) == ["denne", "emojies", "mangler", "oppgaven"]
    @test flexradix(["kobra", "aggie", "agg", "kort", "hyblen", "hanna", "loftet"], 6) == ["agg", "aggie","hanna", "hyblen", "kobra", "kort", "loftet"] # Fra oppgaven
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")