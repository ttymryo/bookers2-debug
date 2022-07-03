class UserMailer < ApplicationMailer

  def group_mail
    @user = User.find(params[:user])
    @group_mail = GroupMail.find(params[:group_mail])
    mail(to: @user.email, subject: 'グループからのお知らせ')
  end
end
