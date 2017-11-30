Fabricator(:review) do
  content  { Faker::Hipster.paragraph(rand(2..8)) }
  rating   { [5,4.5,4,3.5,3,2.5,2,1.5,1].sample }
  created_at { Faker::Time.between(DateTime.now - 1000, DateTime.now)}
end
