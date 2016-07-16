module SessionsHelper

	def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

	def authenticate!
		redirect_to signin_path, notice: "Please sign in" unless current_user
	end

	def signed_in?
		!current_user.nil?
	end

	def correct_user?
		current_user == User.find(params[:id])
	end

	def correct_user!
		redirect_to root_path unless correct_user?
	end

end
