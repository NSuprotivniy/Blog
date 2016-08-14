class User < ActiveRecord::Base

	before_create { generate_token(:auth_token) }

  has_secure_password

  validates :name, presence: true

  validates :email, uniqueness: true,
  									format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
  									presence: true

  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 6 }, allow_blank: true

  has_many :posts
  has_many :comments


	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def delete_password_reset_attr
    self.password_reset_token = nil
    self.password_reset_sent_at = Time.at(0)
    save!
  end

  def send_email_confirmation
    generate_token(:email_confirmation_token)
    save!
    UserMailer.email_confirmation(self).deliver
  end

  def confirm_email
    self.email_confirmed = true
    self.email_confirmation_token = nil
    save!
  end

end
