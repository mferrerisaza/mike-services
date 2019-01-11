class PlayersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @teams = Team.all
  end

  def create
    @player = Player.new(player_params)
    @player.user = current_user
    if @player.save
      redirect_to players_path
    else
      @teams = Team.all
      render 'index'
    end
  end

  private

  def player_params
    params.require(:player).permit(:nickname, :team_id, :user_id)
  end
end
