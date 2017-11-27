class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
  end

  def home
    @no_header = true
  end

  def sign_up
    @no_header = true
  end

  def log_in
    @no_header = true
  end

  layout "application"
end
