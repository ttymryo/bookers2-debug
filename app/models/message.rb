class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :body, length: { maximum: 140 }
end
