class BookCommentsController < ApplicationController
  before_action :set_book

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    BookComment.find(params[:id]).destroy
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  private

  def book_comment_params
    params.permit(:comment)
  end

end
