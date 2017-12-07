class Business < ActiveRecord::Base
  include Starable

  has_many :reviews, -> { order("created_at desc") }
  has_many :businesses_tags
  has_many :tags, :through => :businesses_tags

  default_scope { order(created_at: :desc) }

  validates_presence_of :name, :street_address, :postal_code, :user_id

  before_save :titleize_name_and_address, :format_postal_code, :format_phone_number

  def rating
    reviews.average(:rating)
  end

  def titleize_name_and_address
    self.name = self.name.titleize
    self.community = self.community.titleize
    self.street_address = self.street_address.titleize
  end

  def format_postal_code
    sanitized = self.postal_code.upcase.gsub(/[^A-Z0-9]/, '')
    fsa = sanitized.slice(0, 3)
    ldu = sanitized.slice(3, 3)
    self.postal_code = "#{fsa} #{ldu}"
  end

  def format_phone_number
    self.phone_number = Business.format_phone_number(self.phone_number)
  end

  def self.format_phone_number(phone_number)
    phone_number.gsub!(/\D/, '')
    phone_number.slice!(0) if phone_number[0] == 1
    area_code = phone_number.slice!(0, 3)
    prefix = phone_number.slice!(0, 3)
    line_number = phone_number.slice!(0, 4)
    "(#{area_code}) #{prefix}-#{line_number}"
  end

  def self.search(query)
    sql_query = "tags.name ILIKE ? OR reviews.content ILIKE ? "\
                "OR businesses.name ILIKE ? OR businesses.community ILIKE ?"
    self.includes(:reviews,:tags)
      .where(sql_query, "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
      .references(:reviews,:tags)
  end
end
