class UserMailer < ApplicationMailer

  def group_mail
    @user = User.find(params[:user])
    mail(to: @user.email, subject: 'グループからのお知らせ')
  end
end
