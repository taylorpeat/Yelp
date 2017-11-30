class Business < ActiveRecord::Base
  has_many :reviews

  validates_presence_of :name, :street_address, :postal_code, :user_id

end
