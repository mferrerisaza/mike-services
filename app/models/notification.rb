class Notification < ApplicationRecord
  validates :p256dh, uniqueness: true
end
