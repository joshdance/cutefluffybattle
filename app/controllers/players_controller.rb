class PlayersController < ApplicationController
  #anyone can view all the players and individual players. 
  #have to login to edit and or create new ones. 
  before_filter :authenticate_user!, :except => [:show, :index, :upvote]  
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    #this makes the new pin

    @user = current_user

    @player = current_user.players.build
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    #this is what pulls in the parameters from the form
    @player = current_user.players.build(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @player = Player.find(params[:id])
    @player.increment(:wins)
    @player.save
    calc_win_percentage(@player)
    redirect_to :back
  end

  def flag
    @user = current_user;
    @player = Player.find(params[:id])
    @player.flagged = true
    @player.flagged_by_user_id = @user.id
    @player.save
    redirect_to :back
  end

  def clear_flag
    @user = current_user;
    @player = Player.find(params[:id])
    @player.flagged = false
    @player.flagged_by_user_id = @user.id
    @player.save
    redirect_to :back
  end

  def calc_win_percentage(player)
    player.win_percentage = player.wins.fdiv(player.matches)
    player.save
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    def correct_user
      #correct_user gets run as a before action for the editing actions
      #try to look up the player by the user.
      #if doesn't exist, they don't have permission to edit
      if (!current_user.try(:admin?))
        @player = current_user.players.find_by(id: params[:id])
        redirect_to players_path, notice: "Tricky. You can't edit this fluffy player" if @player.nil?
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :wins, :matches, :win_percentage, :image)
    end
end
