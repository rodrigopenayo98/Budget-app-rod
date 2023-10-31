class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    if params[:id] == 'sign_out'
      sign_out_redirect_to
    else
      find_user
    end
  end

  def find_user
    @user = User.find_by(id: params[:id])
    redirect_to user_path, alert: 'User not found' unless @user
  end

  def sign_out_redirect_to
    sign_out current_user
    redirect_to new_user_session_path
  end
end
