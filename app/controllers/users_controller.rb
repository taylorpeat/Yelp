class UsersController < ApplicationController
  def new
    @header = :plain_banner
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to businesses_path
    else
      flash[:error] = "User could not be created."
      redirect_to register_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
