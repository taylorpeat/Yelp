class BusinessesController < ApplicationController
  
  before_filter :require_user, except: [:index, :show]

  def index
    @businesses = Business.limit(10)
  end

  def new
    @business = Business.new
  end

  def create
    business = Business.new(business_params)
    
    if business.save
      redirect_to businesses_path
    else
      @business = Business.new
      flash.now[:error] = "You must enter a valid business name and address."
      render :new
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :community, :street_address, :postal_code, :phone_number, :price_range)
  end
end