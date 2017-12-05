class Business < ActiveRecord::Base
  include Starable

  has_many :reviews, -> { order("created_at desc") }
  has_many :businesses_tags
  has_many :tags, :through => :businesses_tags

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

  def self.search(query)
    self.joins(:reviews).where("name ILIKE ? OR content ILIKE ?", "%#{query}%", "%#{query}%").distinct
  end
end
