class Business < ActiveRecord::Base
  include Starable
  
  has_many :reviews

  validates_presence_of :name, :street_address, :postal_code, :user_id

  def rating
    reviews.average(:rating)
  end
end
