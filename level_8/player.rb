class Player

	def initialize

		@health = 20
		@lastHealthLevel = 20
		@minHealth = 6
		@timesAttackedContinuously = 0
		@stepsBack = 0
		@maxStepsBack = 3
		@needsRest = false
		@directions = [:forward, :backward]
		@direction = :forward
		@direction2 = :backward
		@isAllClear = false

	end
	
	def play_turn(warrior)

		
		if warrior.health < @lastHealthLevel
			@timesAttackedContinuously += 1
			@lastHealthLevel = warrior.health
		else
			@timesAttackedContinuously = 0
		end

		if @timesAttackedContinuously > 1
			@direction = :backward
			@direction2 = :forward
			
		end

		if  (warrior.feel(@direction).wall? && !@isAllClear) 
			@direction = :backward
			@direction2 = :forward
			@isAllClear = true
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

			path = warrior.look(@direction)

			puts path

			if isEmptyPath(path) 
			 	warrior.walk!(@direction) 
			else
					warrior.shoot!(@direction) 
				
			end

/
			if warrior.feel(@direction).empty?
				warrior.walk!(@direction)
			else
				if warrior.feel(@direction).captive?
					warrior.rescue!(@direction)
				else
					warrior.attack!(@direction)
				end
			end
/
	end

	def isEmptyPath(path)

		path.each do |space|
			if space.stairs?
				return true
				
			end
			if !space.empty? 
				return false
			end
		end
		return true

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
