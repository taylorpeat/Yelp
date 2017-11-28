class UsersController < ApplicationController
  def new
    @no_header = true
    @user = User.new
  end

  def create

  end
end
