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
      render :new
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :community, :stree_address, :postal_code, :phone_number)
  end
end