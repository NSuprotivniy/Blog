class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by_email(params[:session][:email])

		if @user && sign_in(@user, params[:session][:password])
				if @user.email_confirmed
					flash[:success] = "Welcome!"
				else
					flash[:warning] = "Please activate your account by following the
        											instructions in the account confirmation email
        											you received to proceed"
				end

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
