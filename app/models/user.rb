class User < ActiveRecord::Base

	before_create { generate_token(:auth_token) }

  has_secure_password

  validates :name, presence: true
  
  validates :email, uniqueness: true, 
  									format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
  									presence: true
  
  validates :password, presence: true,
  										 length: { minimum: 6 }

  has_many :posts
  has_many :comments


	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	end

end
