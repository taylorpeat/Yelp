SAMPLE_COVER_IMAGES = ['alo_restaurant', 'byblos', 'katsuya', 'kinka_izakaya_original', 'lunita', 'pai_northern_thai_kitchen', 'pearl_diver', 'rasa', 'richmond_station', 'under_the_table_restaurant']

class BusinessesController < ApplicationController
  
  before_filter :require_user, only: [:create, :new]

  def index
    @page = (params[:p] || 1).to_i - 1
    @businesses = Business.all
    @display_businesses = @businesses.limit(10).offset(10 * @page)
  end

  def search
    @query = params[:query]
    @page = (params[:p] || 1).to_i - 1
    @businesses = Business.search(@query)
    @display_businesses = @businesses.limit(10).offset(10 * @page)
    render :index
  end

  def new
    @business = Business.new
  end

  def create
    business = Business.new(business_params)
    business.phone_number = Business.format_phone_number(business.phone_number)
    business.cover_image = SAMPLE_COVER_IMAGES.sample
    business.tags << parse_tags(params.require("tags"))

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

  def parse_tags(tag_string="")
    tags = []
    tag_names = tag_string.split(/\sand\s|,\s+|,/)

    tag_names.each do |tag_name|
      exist_tag = Tag.find_by(name: tag_name)
      
      if exist_tag
        tags << exist_tag
      else
        tags << Tag.create(name: tag_name)
      end
    end

    tags
  end

end