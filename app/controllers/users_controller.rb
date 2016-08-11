class UsersController < ApplicationController

	before_action :authenticate!, except: [:index, :show, :new, :create]
	before_action :correct_user!, only: [:edit, :update, :destroy]

	def index
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.posts.paginate(page: params[:page], per_page: 20).order("created_at DESC")
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			cookies.permanent[:auth_token] = @user.auth_token
			flash[:success] = "Welcome aboard!"
			redirect_to root_path
		else
			render "new"
		end
	end

	def edit
	end

	def update

		if current_user.update(user_params)
			flash[:success] = "Updated"
			redirect_to current_user
		else
			render "edit"
		end
	end

	def destroy
		current_user.destroy
		cookies.delete(:auth_token)
		redirect_to root_path
	end


	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
