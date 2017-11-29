class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :first_name, :last_name, :email

  def full_name
    "#{first_name} #{last_name}"
  end
end