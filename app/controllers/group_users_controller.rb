class GroupUsersController < ApplicationController

  def create
    user =  GroupUser.new(group_id: params[:id], user_id: current_user.id)
    user.save
    redirect_to group_path(params[:id])
  end

  def destroy
    user =  GroupUser.find_by(group_id: params[:id], user_id: current_user.id)
    user.destroy
    redirect_to group_path(params[:id])
  end

end
