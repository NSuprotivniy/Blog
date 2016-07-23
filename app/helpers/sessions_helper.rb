module SessionsHelper

	def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

	def authenticate!
		unless current_user
			store_location
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

	def correct_user!(user = User.find(params[:id]))
		unless correct_user? user
			flash[:danger] = "You have no access"
			redirect_to :back 
	  end
	  rescue ActionController::RedirectBackError
	  	redirect_to root_path
	end

	def correct_post_user!(post = Post.find(params[:id]))
		correct_user! post.user
	end

	def correct_comment_user!(comment = Comment.find(params[:id]))
		correct_user! comment.user
	end

end
