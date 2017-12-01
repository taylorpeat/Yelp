SAMPLE_COVER_IMAGES = ['alo_restaurant', 'byblos', 'katsuya', 'kinka_izakaya_original', 'lunita', 'pai_northern_thai_kitchen', 'pearl_diver', 'rasa', 'richmond_station', 'under_the_table_restaurant']

class BusinessesController < ApplicationController
  
  before_filter :require_user, except: [:index, :show]

  def index
    @page = (params[:p] || 1).to_i - 1
    @businesses = Business.limit(10).offset(10 * @page)
  end

  def new
    @business = Business.new
  end

  def create
    business = Business.new(business_params)
    business.cover_image = SAMPLE_COVER_IMAGES.sample

    if business.save
      redirect_to business_path(business)
    else
      @business = Business.new
      flash.now[:error] = "You must enter a valid business name and address."
      render :new
    end
  end

  def show
    @business = Business.find(params[:id])
  end

  private

  def business_params
    params.require(:business).permit(:name, :community, :street_address, :postal_code, :phone_number, :price_range).merge({ user_id: current_user.id })
  end
end