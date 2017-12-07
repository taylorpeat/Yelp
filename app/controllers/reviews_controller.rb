class ReviewsController < ApplicationController
  before_filter :require_user

  def create
    review = Review.new(review_params)
    unless review.save
      flash[:error] = "The review could not be saved."
    end 

    redirect_to business_path(params[:business_id])
  end
end

def review_params
  params.require(:review).permit(:rating, :content)
    .merge({ business_id: params[:business_id] }).merge({ user_id: current_user.id })
end