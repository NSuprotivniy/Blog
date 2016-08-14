class UsersController < ApplicationController

	before_action :authenticate!, except: [:index, :show, :new, :create, :email_confirmation]
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

		if @user.save && sign_in(@user, user_params[:password])
			@user.send_email_confirmation
			flash[:success] = "Welcome aboard! Please confirm your email before you start."
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

	def email_confirmation
		@user = User.find_by_email_confirmation_token(params[:id])

		if @user && @user.confirm_email
			flash[:success] = "Welcome to Blog! You have successfuly confirmed your email."
			if signed_in?
				redirect_to root_path
			else
				redirect_to new_session_path
			end
		else
			flash[:danger] = "Invalid email confirmation link."
			redirect_to root_path
		end
	end


	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
