class Business < ActiveRecord::Base
  include Starable

  has_many :reviews, -> { order("created_at desc") }

  validates_presence_of :name, :street_address, :postal_code, :user_id

  def rating
    reviews.average(:rating)
  end

  def total_pages
    reviews.count / 10
  end

  def self.total_pages
    count / 10
  end

  def self.pagination_pages
    total_pages > 9 ? 9 : total_pages + 1
  end
end
