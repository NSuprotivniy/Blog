# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    User.first.send_password_reset
  end

  def email_confirmation
    User.first.send_email_confirmation
  end

end
