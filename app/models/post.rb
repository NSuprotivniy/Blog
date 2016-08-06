class Post < ActiveRecord::Base

	validates :title, :body, presence: true

	belongs_to :user

	has_many :comments, dependent: :destroy

	has_many :pictures, dependent: :destroy

end
