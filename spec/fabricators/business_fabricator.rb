COVER_IMAGES = %w(agio alo_restaurant black_briik byblos gb_noodles gusto gyubee katsuya khoa_san_road kinka_izakaya_original koyoi lunita pai_northern_thai_kitchen patria pearl_diver playa_cabana rasa richmond_station scaramouche tibet_kitchen under_the_table_restaurant yasu)
COMMUNITIES = %w(The/ Annex Kensington/ Market Riverdale Harbourfront Beaches Cabbagetown Bloor/ West Village Corktown High/ Park Leslieville Little/ Italy Parkdale Rosedale Yorkville)

Fabricator(:business) do
  name { Faker::Company.name }
  cover_image { COVER_IMAGES.sample }
  community { COMMUNITIES.sample }
  street_address { Faker::Address.building_number + " " + Faker::Address.street_name }
  phone_number { Business.format_phone_number(Faker::PhoneNumber.phone_number) }
  price_range { 1 + rand(5) }
  postal_code { generate_postal_code }
  user_id { Fabricate(:user).id }
  tags { Tag.all.sample(rand(3) + 1) || [Fabricate(:tag)] }
end

def generate_postal_code
  "#{rand_let}#{rand(10)}#{rand_let} #{rand(10)}#{rand_let}#{rand(10)}"
end

def rand_let
  [*'A'..'Z'].sample
end