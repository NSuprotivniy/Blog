module SessionsHelper

	def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

	def authenticate!
		unless current_user
			flash[:warning] = "Please sign in"
			redirect_to signin_path
		end
	end

	def signed_in?
		!current_user.nil?
	end

	def correct_user?(user = User.find(params[:id]))
		current_user == user
	end

	def correct_user!
		redirect_to root_path unless correct_user?
	end

end
