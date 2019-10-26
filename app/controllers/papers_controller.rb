class PapersController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: :update

  def index
    @papers = Paper.where(count: params[:count].to_i).where(team: nil).order('random()')
    @team1 = Team.first
    @team2 = Team.second
  end

  def new
  end

  def create
    player = Player.find(JSON.parse(cookies[:player])["id"])
    rounds = [1, 2, 3]
    rounds.each do |round|
      Paper.create(description: params[:paper][:paper_1], player: player, count: round)
      Paper.create(description: params[:paper][:paper_2], player: player, count: round)
      Paper.create(description: params[:paper][:paper_3], player: player, count: round)
    end
    change_player_status(player.id)
    redirect_to players_path
  end

  def update
    @paper = Paper.find(params[:id])
    @paper.update(paper_params)
    render json: 200
  end

  def reset
    cookies[:player] = nil
    Team.destroy_all
    Player.destroy_all
    redirect_to papelitos_path
    ActionCable.server.broadcast "player", { action: "game_restart" }
    $redis.set("button_changes", 0)
  end

  private

  def paper_params
    params.require(:paper).permit(:team_id, :count)
  end

  def change_player_status(player_id)
    ActionCable.server.broadcast "player", {
      action: "change_player_status",
      icon: "<i class='em em-white_check_mark'></i>",
      playerId: player_id
    }
  end
end
