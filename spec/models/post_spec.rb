require 'rails_helper'

RSpec.describe Post, type: :model do


	context "presence of content" do
		
		let(:post) { $post = Post.new}
		
		it "should have title" do
			post.body = "blabla"
			expect{ post.save }.not_to change{ Post.count }
		end

		it "should have body" do
			post.title = "blabla"
			expect{ post.save }.not_to change{ Post.count }
		end

		it "should be valid" do
			post.title = "blabla"
			post.body = "blabla"
			expect{ post.save }.to change{ Post.count }.by(1)
		end

	end

end
