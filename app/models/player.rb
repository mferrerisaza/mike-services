class Player < ApplicationRecord
  belongs_to :team
  belongs_to :user
  has_many :papers
end
