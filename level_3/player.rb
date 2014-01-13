class Player

	
  def play_turn(warrior)
    
  	

  	if warrior.health < 19 
  	 	if !warrior.feel.empty?
  			warrior.walk!(:backward)
  		else
  			warrior.rest!
  		end
  	else
  		
  		if warrior.feel.empty?
			warrior.walk!
		else
			warrior.attack!
		end
	end


  end
end
