class Tag < ActiveRecord::Base
  has_many :businesses, :through => :businesses_tags
  has_many :businesses_tags
end
