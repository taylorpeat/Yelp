class User < ActiveRecord::Base
  has_many :businesses
  has_many :reviews, -> { order("created_at desc") }

  has_secure_password

  validates_presence_of :first_name, :last_name, :email

  def display_name
    "#{first_name} #{last_name.slice(0)}."
  end

  def initials
    first_name.slice(0) + last_name.slice(0)
  end
end