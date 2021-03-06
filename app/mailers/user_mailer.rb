class UserMailer < ApplicationMailer



  def password_reset(user)
    @user = user
    mail to: "#{user.name} <#{user.email}>", subject: "Password reset"
  end

  def email_confirmation(user)
    @user = user
    mail to: "#{user.name} <#{user.email}>", subject: "Email confirmation"
  end
end
