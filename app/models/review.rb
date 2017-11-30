class Review < ActiveRecord::Base
  include Starable

  belongs_to :user
  belongs_to :business

  validates_presence_of :content, :rating, :user_id, :business_id
  validates_uniqueness_of :business_id, scope: :user_id

  def date
    created_at.strftime("%m/%d/%Y")
  end
end
