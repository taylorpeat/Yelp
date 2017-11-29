class BusinessesController < ApplicationController
  def index
    @businesses = Business.limit(10)
  end

  def new
    @business = Business.new
  end
end