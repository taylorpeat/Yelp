class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
  end

  def home
    @header = :none
  end

  layout "application"
end
