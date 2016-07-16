class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by_email(params[:session][:email])

		if @user && @user.authenticate(params[:session][:password])
			cookies.permanent[:auth_token] = @user.auth_token
			redirect_to root_path, notice: "Logged in"
		else
			render 'new'
		end
	end

	def destroy
		cookies.delete(:auth_token)
		redirect_to root_path, notice: "Logged out"
	end
end
