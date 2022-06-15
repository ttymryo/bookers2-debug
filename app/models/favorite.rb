class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :book_id, scope: :user_id

  def set_books_week
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @book_week = Book.includes(:favorited_users).
      sort {|a,b|
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
      }
  end

end
