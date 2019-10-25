#=
mincoins:
- Julia version: 1.2.0
- Author: hannahjelmeland
- Date: 2019-10-25
=#
function usegreed(coins)
    for i = 1:length(coins)-1
		if coins[i]%coins[i + 1] != 0
			return false
		end
	end
	return true
end
function mincoinsgreedy(coins, value)
	c = 0
	for i in coins
		while value >= i
			value -= i
			c += 1
		end
	end
	return c
end
function mincoins(coins, value)
    if usegreed(coins)
    	return mincoinsgreedy(coins, value)
	end
	n = length(coins)
	inf = typemax(Int32)
	t = [inf for i in 1:value + 1]
	t[1] = 0
    for i in 1:value
        for j in 1:n
            if i >= coins[j]
                t[i+1] = min(t[i - coins[j] + 1] + 1, t[i + 1])
            end
        end
    end
    return t[value + 1]
end
#mincoins([10, 7, 1]) == 2
#mincoins([4,3,1],18) == 5 gir 3*4 + 2*3 = 5
#mincoins([120, 60, 30, 15, 5, 1], 20) == 2

### Tester ###
# Disse testene blir kjørt når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test mincoins([4,3,1],18) == 5
  @test mincoins([1000,500,100,30,7,1],14) == 2
  @test mincoins([40, 30, 20, 10, 1], 90) == 3
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")