class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
end
