class Team < ApplicationRecord
  has_many :papers, dependent: :destroy
  has_many :players, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
