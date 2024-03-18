class PasswordResetsController < ApplicationController
  before_action :set_user_by_token, only: [:edit, :update]

  def new    
  end

  def create
    if (user = User.find_by(email: params[:email]))
      PasswordMailer.with(
        user: user,
        token: user.generate_token_for(:password_reset)
      ).password_reset.deliver_later
    end

    redirect_to root_path, notice: "Check your inbox for a password reset email."
  end

  def edit
  end

  def update
    if @user.update(password_params)
      redirect_to new_session_path, notice: "Your password has been reset successfully. Please log in.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_token_for(:password_reset, params[:token])
    unless @user.present?
      redirect_to new_password_resets_path, alert: "Invalid token, please request a new password reset email.", status: :see_other
    end
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
