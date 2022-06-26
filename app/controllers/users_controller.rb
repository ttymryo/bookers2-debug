class UsersController < ApplicationController
  before_action :ensure_correct_user, only: %i[update edit destroy]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    message
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else
      render 'edit'
    end
  end

  def message
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
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

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    user = User.find(params[:id])
    redirect_to user_path(current_user) unless user == current_user
  end
end
