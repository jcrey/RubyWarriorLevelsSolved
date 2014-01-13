class Player

	def initialize

		@health = 20
		@lastHealthLevel = @health
		@minHealth = 10
		@timesAttackedContinuously = 0
		@stepsBack = 0
		@maxStepsBack = 3
		@needsRest = false
		@directions = [:forward, :backward]
		@direction = :forward
		@direction2 = :backward
		@isLeftSideClear = false

	end
	
	def play_turn(warrior)


		if !warrior.feel(:backward).wall? && !@isLeftSideClear
			@direction = :backward
			@direction2 = :forward
		else
			@isLeftSideClear = true
			@direction = :forward
			@direction2 = :backward
		end

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

			if warrior.feel(@direction).empty?
				warrior.walk!(@direction)
			else
				if warrior.feel(@direction).captive?
					warrior.rescue!(@direction)
				else
					warrior.attack!(@direction)
				end
			end
			
	end

	def recoverBlood (warrior)

		if @stepsBack == @maxStepsBack

			warrior.rest!

		else

			warrior.walk!(@direction2)
			@stepsBack += 1

		end

		if warrior.health == @health

			@needsRest = false
			@stepsBack = 0

		end

	end


end
