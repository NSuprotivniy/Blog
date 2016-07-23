class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by_email(params[:session][:email])

		if @user && @user.authenticate(params[:session][:password])
			cookies.permanent[:auth_token] = @user.auth_token
			flash[:success] = "Welcome!"
			redirect_back_or root_path
		else
			flash.now[:danger] = "Invalid email or password"
			render 'new'
		end
	end

	def destroy
		cookies.delete(:auth_token)
		flash[:success] = "Logged out. See you soon!"
		redirect_to root_path
	end
end
