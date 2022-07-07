class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :group_mail, dependent: :destroy
  has_one_attached :group_image

  validates :name, presence: true
  validates :introduction, presence: true

  def get_image
    group_image.attached? ? profile_image : '/no_image.jpg'
  end
end
