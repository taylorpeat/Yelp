TAGS = %w(Italian Caribbean Breakfast Pizza Burgers Desserts Japanese Thai Mediterranean Middle\ Eastern Pubs French Seafood Barbecue Steakhouse Chinese Mexican Vegetarian)

TAGS.each { |t| Fabricate(:tag, name: t) }

120.times { Fabricate(:user) }
users = User.all

120.times { Fabricate(:business, user_id: users.sample.id, tags: Tag.all.sample(rand(3) + 1)) }

businesses = Business.all

businesses.each do |business|
  rand(5..25).times do
    user = users.sample
    if !business.reviews.find_by(user_id: user.id)
      Fabricate(:review, business_id: business.id, user_id: user.id)
    end
  end
end