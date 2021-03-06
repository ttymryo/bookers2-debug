class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i[edit update destroy]

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @book_comment = BookComment.new
    message
    view_count
  end

  def index
    @book = Book.new
    book_week
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
      book_week
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user_id == current_user.id
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def book_week
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @book_week = Book.all.sort do |a, b|
      b.favorites.where(created_at: from...to).size <=>
        a.favorites.where(created_at: from...to).size
    end
  end

  def newsort
    @books_new = Book.all.order(created_at: :desc)
  end

  def starsort
    @books_star = Book.all.order(star: :desc)
  end

  def message
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @book.user.id)
    unless @book.user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      unless @is_room
        @entry = Entry.new
      end
    end
  end

  def view_count
    unless @book.user.id == current_user.id
      book_view = BookView.find_by(user_id: current_user.id, book_id: @book.id)
      BookView.create(user_id: current_user.id, book_id: @book.id) if book_view.nil?
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user == current_user
  end
end
