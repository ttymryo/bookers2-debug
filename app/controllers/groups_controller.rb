class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def create
    group = Group.create(group_params)
    group_user = GroupUser.new(user_id: current_user, group_id: group)
    group_user.save
    redirect_to groups_path
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id)
  end
end
