class Player

	def initialize

		@health = 20
		@lastHealthLevel = @health
		@minHealth = 10
		@timesAttackedContinuously = 0
		@stepsBack = 0
		@maxStepsBack = 2
		@needsRest = false

	end
	
	def play_turn(warrior)

	    if haveEnoughBlood(warrior.health, @minHealth)

	    	goFowardAndAtack(warrior)

	    else

	    	recoverBlood(warrior)

	    end


	end


	def haveEnoughBlood (actualHealth, minHealth)

		if !@needsRest && actualHealth > minHealth 
			return true
		else
			@needsRest = true
			return false
		end

	end

	def goFowardAndAtack(warrior)

			if warrior.feel.empty?
				warrior.walk!
			else
				warrior.attack!
			end
			
	end

	def recoverBlood (warrior)

		if @stepsBack == @maxStepsBack

			warrior.rest!

		else

			warrior.walk!(:backward)
			@stepsBack += 1

		end

		if warrior.health == @health

			@needsRest = false
			@stepsBack = 0

		end

	end


end
