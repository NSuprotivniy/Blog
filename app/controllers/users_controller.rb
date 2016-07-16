class UsersController < ApplicationController

	before_action :authenticate!, except: [:index, :show, :new, :create]
	before_action :correct_user!, only: [:edit, :update, :destroy]

	def index
	end

	def show
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			cookies.permanent[:auth_token] = @user.auth_token
			redirect_to root_path, notice: "Welcome aboard!"
		else
			flash.now.alert = "Invalid"
			render "new"
		end
	end

	def edit
	end

	def update

		if current_user.update(user_params)
			redirect_to current_user, notice: "Updated"
		else
			flash.now.alert = "Invalid"
			render "edit"
		end
	end

	def destroy
		cookies.delete(:auth_token)
		current_user.destroy
		redirect_to root_path
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
