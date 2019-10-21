class TeamsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    render json: Team.all, include: :players
  end

  def show
    @team = Team.find(params[:id])
    min_rounds = Player.where(team: @team).minimum(:played_rounds)
    @players = Player.where(team: @team).where(played_rounds: min_rounds).sample
    render json: @players
  end

  def new
    @team = Team.new
  end

  def create
    @team_1 = Team.new(name: team_params[:team_1])
    @team_2 = Team.new(name: team_params[:team_2])
    if @team_1.save && @team_2.save
      flash[:notice] = "Habemous equipos, prosiga"
      redirect_to players_path
    else
      Team.destroy_all
      flash.now[:alert] = "La cagó revise que todos los equipos tengan nombre y no esté repetido"
      render 'new'
    end
  end

  private

  def team_params
    params.require(:teams).permit(:team_1, :team_2)
  end
end
