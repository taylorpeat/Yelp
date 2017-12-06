class Tag < ActiveRecord::Base
  has_many :businesses, :through => :businesses_tags
  has_many :businesses_tags

  before_save :titleize_name

  def titleize_name
    self.name = self.name.titleize
  end
end
