class PapersController < ApplicationController
  def index
    @papers_round_1 = Paper.where(count: 1).order('random()')
    @papers_round_2 = Paper.where(count: 2).order('random()')
    @papers_round_3 = Paper.where(count: 3).order('random()')
  end

  def new
  end

  def create
    rounds = [1, 2, 3]
    rounds.each do |round|
      Paper.create(description: params[:paper][:paper_1], player: current_user.player, count: round)
      Paper.create(description: params[:paper][:paper_2], player: current_user.player, count: round)
      Paper.create(description: params[:paper][:paper_3], player: current_user.player, count: round)
    end
    redirect_to players_path
  end
end
