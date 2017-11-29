class Business < ActiveRecord::Base
  validates_presence_of :name, :street_address, :postal_code
end
