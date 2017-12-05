# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TAGS = %w(italian caribbean breakfast pizza burgers desserts japanese thai mediterranean middle\ eastern pubs french seafood barbecue steakhouse chinese mexican vegetarian)

TAGS.each { |t| Fabricate(:tag, name: t) }

30.times { Fabricate(:user) }
users = User.all

15.times { Fabricate(:business, user_id: users.sample.id, tags: Tag.all.sample(rand(3) + 1)) }

businesses = Business.all

businesses.each do |business|
  rand(5..25).times do
    user = users.sample
    if !business.reviews.find_by(user_id: user.id)
      Fabricate(:review, business_id: business.id, user_id: user.id)
    end
  end
end