class Paper < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :player
end
