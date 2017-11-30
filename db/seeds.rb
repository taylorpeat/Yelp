# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

30.times { Fabricate(:user) }

users = User.all

15.times { Fabricate(:business, user_id: users.sample.id)}

businesses = Business.all

businesses.each do |business|
  rand(5..25).times do
    user = users.sample
    if !business.reviews.find_by(user_id: user.id)
      Fabricate(:review, business_id: business.id, user_id: user.id)
    end
  end
end