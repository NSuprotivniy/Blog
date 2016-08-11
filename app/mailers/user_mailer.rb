class UserMailer < ApplicationMailer



  def password_reset(user)
    @user = user
    mail to: "#{user.name} <#{user.email}>", subject: "Password verification" if user
  end
end