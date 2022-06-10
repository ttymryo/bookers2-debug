class Favorite < ApplicationRecord

  belongs_to :usre, optional:true
  belongs_to :book

  validates :user_id, presence: true
  validates :book_id, presence: true

end
