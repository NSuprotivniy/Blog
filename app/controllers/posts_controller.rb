class PostsController < ApplicationController

	before_action :authenticate!, except: [:index, :show]
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :correct_post_user!, only: [:edit, :update, :destroy]


	def index
		@posts = Post.paginate(page: params[:page], per_page: 20).order("created_at DESC")
	end

	def new
		@post = current_user.posts.new
	end

	def create

		@post = current_user.posts.build(post_params)

		# @pictures = build_pictures @post

		if @post.save # && @pictures.all? {|pic| pic.save}
			flash[:success] = "Looks great!"
			redirect_to @post
		else
			# @pictures.each {|pic| pic.destroy}
			render 'new'
		end


	end


	def show
		@comments = @post.comments.paginate(page: params[:comment_page], per_page: 20).order("created_at DESC")
		@comment = @post.comments.new
	end

	def edit
	end

	def update

		# @pictures = build_pictures @post

		if @post.update(post_params) # && !@pictures || @pictures.all? {|pic| pic.save}
			flash[:success] = "Looks great!"
			redirect_to @post
		else
			# @pictures.each {|pic| pic.destroy}
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	private

	def post_params
		params.require(:post).permit(:title, :body)
	end

	def find_post
		@post = Post.find(params[:id])
	end

	# def build_pictures(post)
	# 	pictures = []

	# 	if params[:images]
	# 		params[:images].each do |image|
	# 			pictures << post.pictures.build(image: image)
	# 		end
	# 	end

	# 	pictures
	# end


end
