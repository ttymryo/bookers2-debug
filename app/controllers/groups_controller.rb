class GroupsController < ApplicationController
  def new
  end

  def create
    group = Group.new(group_params)
    group.save
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id)
  end
end
