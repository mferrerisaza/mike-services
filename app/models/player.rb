class Player < ApplicationRecord
  belongs_to :team
  belongs_to :user
  has_many :papers, dependent: :destroy

  def papers_size
    papers.size / 3
  end

  def ready_to_play?
    papers.size == 9
  end
end
