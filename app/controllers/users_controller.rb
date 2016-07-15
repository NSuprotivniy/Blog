class UsersController < ApplicationController

	before_action :authenticate!, except: [:index, :show, :new, :create]

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
			session[:user_id] = @user.id
			redirect_to root_path, notice: "Welcome board!"
		else
			flash.now = "Invalid"
			render "new"
		end
	end

	def edit
	end

	def update

		if current_user.update(user_params)
			redirect_to current_user, notice: "Updated"
		else
			flash.now = "Invalid"
			render "edit"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
