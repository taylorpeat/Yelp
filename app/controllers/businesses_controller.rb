class BusinessesController < ApplicationController
  def index
    @businesses = Business.limit(10)
  end
end