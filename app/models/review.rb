class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  validates_presence_of :content, :rating, :user_id, :business_id
end
