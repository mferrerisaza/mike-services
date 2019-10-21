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
  end

  private

  def paper_params
    params.require(:paper).permit(:team_id, :count)
  end
end
