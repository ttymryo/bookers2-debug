class FavoritesController < ApplicationController
  before_action :set_book

  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    set_books_week
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    set_books_week
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_books_week
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @book_week = Book.all.sort {|a,b|
      b.favorites.where(created_at: from...to).size <=>
      a.favorites.where(created_at: from...to).size
    }
  end

end
