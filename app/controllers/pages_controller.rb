class PagesController < ApplicationController
  def home
  	players = Player.limit(2).order("RANDOM()").where(flagged: nil)
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

  def champion
  	@champion = Player.order('win_percentage DESC').first
  end

  def admin
    @players = Player.all.where(flagged: true)
  end

end
