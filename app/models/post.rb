class Post < ActiveRecord::Base

	validates :title, :body, presence: true

	belongs_to :user

	has_many :comments, dependent: :destroy

	# has_many :pictures, dependent: :destroy

  include PgSearch
  pg_search_scope :search_posts,
                  against: [:title, :body],
                  using: { tsearch: { prefix: true, dictionary: "english", any_word: true } },
                  associated_against: { user: [:email, :name] }




end
