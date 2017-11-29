class BusinessesController < ApplicationController
  
  before_filter :require_user, except: [:index, :show]

  def index
    @businesses = Business.limit(10)
  end

  def new
    @business = Business.new
  end
end