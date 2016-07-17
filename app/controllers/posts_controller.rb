class PostsController < ApplicationController

	before_action :authenticate!, except: [:index, :show]
	before_action :find_post, only: [:show, :edit, :update, :destroy]

	def index 
		@posts = Post.paginate(page: params[:page], per_page: 20).order("created_at DESC")
	end

	def new
		@post = current_user.posts.new
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			flash[:success] = "Looks great!"
			redirect_to @post
		else
			render 'new'
		end
	end


	def show
	end

	def edit
	end

	def update
		if @post.update(post_params)
			flash[:success] = "Looks great!"
			redirect_to @post
		else
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

end
