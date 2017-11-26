class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
  end

  def home
  end

  layout "application"
end
