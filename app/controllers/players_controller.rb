class PlayersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @teams = Team.all
    @teams_ready = true #@teams.all? { |team| team.players.size >= 2 }
    @papers_round1 = Paper.where(count: 1).where(team: nil)
    @papers_round2 = Paper.where(count: 2).where(team: nil)
    @papers_round3 = Paper.where(count: 3).where(team: nil)
    @current_player = Player.find(session[:player]["id"]) if session[:player]
    @users_ready = Player.all.all?(&:ready_to_play?)
  end

  def create
    @player = Player.new(player_params)
    # @player.user = current_user
    if @player.save
      redirect_to players_path
      session[:player] = @player
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
