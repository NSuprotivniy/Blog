class PasswordResetController < ApplicationController


  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user
      user.send_password_reset
      flash[:success] = "Email sent with password reset instructions."
      redirect_to root_path

    else
      flash.now[:danger] = "No users found"
      render 'new'
    end
  end

  def edit
    @user = User.find_by_password_reset_token(params[:id])
    unless @user
      flash[:danger] = "Your password reset link has outdated or invalid."
      redirect_to new_password_reset_path
    end
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])

    if @user.password_reset_sent_at < 2.hours.ago

      @user.delete_password_reset_attr

      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_path

    elsif @user.update_attributes(user_params)

      @user.delete_password_reset_attr

      @user.authenticate(user_params[:password])
      cookies.permanent[:auth_token] = @user.auth_token

      flash[:success] = "Password has been reset!"
      redirect_to root_url

    else
      render 'edit'
    end
  end

private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
