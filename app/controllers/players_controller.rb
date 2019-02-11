class PlayersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @teams = Team.all
    @teams_ready = @teams.all? { |team| team.players.size >= 2 }
    @papers_round1 = Paper.where(count: 1).where(team: nil)
    @papers_round2 = Paper.where(count: 2).where(team: nil)
    @papers_round3 = Paper.where(count: 3).where(team: nil)
    @users_ready = User.all.all? { |user| user.player && user.player.papers.count == 9 }
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
