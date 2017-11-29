COVER_IMAGES = ['alo_restaurant', 'byblos', 'katsuya', 'kinka_izakaya_original', 'lunita', 'pai_northern_thai_kitchen', 'pearl_diver', 'rasa', 'richmond_station', 'under_the_table_restaurant']

Fabricator(:business) do
  name { Faker::Company.name }
  cover_image { COVER_IMAGES.sample }
  community { Faker::Address.community }
  street_address { Faker::Address.building_number + " " + Faker::Address.street_name }
  phone_number { format_phone_number(Faker::PhoneNumber.phone_number) }
  price_range { 1 + rand(5) }
  postal_code { generate_postal_code }
end

def format_phone_number(phone_number)
  phone_number.delete!("()-.x")
  phone_number.slice!(0) if phone_number[0] == 1
  area_code = phone_number.slice!(0, 3)
  prefix = phone_number.slice!(0, 3)
  line_number = phone_number.slice!(0, 4)
  "(#{area_code}) #{prefix}-#{line_number}"
end

def generate_postal_code
  "#{rand_let}#{rand(10)}#{rand_let} #{rand(10)}#{rand_let}#{rand(10)}"
end

def rand_let
  [*'A'..'Z'].sample
end