class Player < ApplicationRecord
  after_create_commit :add_player_to_game

  belongs_to :team
  belongs_to :user, optional: true
  has_many :papers, dependent: :destroy

  def papers_size
    papers.size / 3
  end

  def ready_to_play?
    papers.size == 9
  end

  def add_player_to_game
    ActionCable.server.broadcast "player", {
      action: "add_player",
      player: ApplicationController.render(
              partial: 'shared/player-card',
              locals: { player: self }
            ).squish,
      teamId: team.id
    }
  end

end
