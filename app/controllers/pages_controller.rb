class PagesController < ApplicationController
  def home
  	players = Player.limit(2).order("RANDOM()")
  	# postgresql
	@player1 = players[0]
  	@player2 = players[1]

  	@player1.increment(:matches)
  	@player1.save
  	@player2.increment(:matches)
  	@player2.save
  end

  def about
  end

end
