class UsersController < ApplicationController
  before_action :authenticated_user, only: [:show]

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Welcome to the OctoAlert!'
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation)
  end

  def authenticated_user
    unless logged_in?
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end

    return if current_user == User.find(params[:id])

    flash[:danger] = 'Not authorized'
    redirect_back(fallback_location: root_path)
  end
end
