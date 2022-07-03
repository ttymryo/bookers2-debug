class GroupMailsController < ApplicationController

  def new
    @group_mail = GroupMail.new
    @group = Group.find(params[:group_id])
  end

  def show
    @group_mail = GroupMail.find(params[:id])
  end

  def create
    group = Group.find(params[:group_id])
    @group_mail = GroupMail.new(group_mail)
    @group_mail.group_id = group.id
    if @group_mail.save
      group.group_users.each do |user|
        UserMailer.with(user: user.user_id,group_mail: @group_mail.id).group_mail.deliver_later
      end
      redirect_to group_group_mail_path(group, @group_mail)
    else
      render 'new'
    end
  end

  private

  def group_mail
    params.require(:group_mail).permit(:group_id, :title, :content)
  end
end
