class SessionsController < ApplicationController
  def new
    @header = :plain_banner
    redirect_to business_index_path if session[:user_id]
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to business_index_path, notice: "You are signed in. Enjoy!"
    else
      flash[:error] = "Invalid email or password."
      redirect_to log_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been signed out."
    redirect_to home_path
  end
end