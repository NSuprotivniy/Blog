class CommentsController < ApplicationController

	before_action :authenticate!
	before_action :correct_comment_user!, only: [:destroy]
	before_action :find_post
	

	def create
		@comment = @post.comments.build(comment_params)
		@comment.user = current_user
		if @comment.save
			redirect_to @post
		else
			flash.now[:danger] = "Comment has not created"
		end

	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to @post
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

	def find_post
		@post = Post.find(params[:post_id])
	end


end
