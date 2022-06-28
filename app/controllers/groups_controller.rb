class GroupsController < ApplicationController
  before_action :set_book

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
    redirect_to groups_path unless @group.owner_id == current_user.id
  end

  def create
    group = Group.new(group_params)
    if group.save
      group_user = GroupUser.new(user_id: current_user.id, group_id: group.id)
      group_user.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def update
    group = Group.find(params[:id])
    if group.update(group_params)
      redirect_to groups_path
    else
      render 'edit'
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path
  end

  def set_book
    @book_new = Book.new
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id)
  end
end
