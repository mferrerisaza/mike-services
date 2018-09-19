class Task < ApplicationRecord
  validates :description, :user, presence: true
end
