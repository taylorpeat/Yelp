require 'rails_helper'

describe Business, type: :model do
  it { should have_many(:reviews).order("created_at desc") }
  it { should have_many(:tags).through(:businesses_tags) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:postal_code) }
  it { should validate_presence_of(:user_id) }

  describe "#search" do
    it "returns a business with matching name" do
      business = Fabricate(:business, name: "Food Truck")
      expect(Business.search("Food")).to eq([business])
    end

    it "returns a business with matching review" do
      business = Fabricate(:business, name: "Food Truck")
      Fabricate(:review, business_id: business.id, content: "Cheese")
      expect(Business.search("Cheese")).to eq([business])
    end

    it "doesn't return business with no matching elements" do
      business = Fabricate(:business, name: "Food Truck")
      expect(Business.search("Paper")).to eq([])
    end

    it "returns multiple matching businesses" do
      business1 = Fabricate(:business, name: "Food Truck")
      business2 = Fabricate(:business, name: "Taxi Place")
      Fabricate(:review, business_id: business2.id, content: "Taxi Place has Food")
      expect(Business.search("Food").to_a).to contain_exactly(business1, business2)
    end

    it "ignores case when matching" do
      business = Fabricate(:business, name: "Food Truck")
      expect(Business.search("food")).to eq([business])
    end
  end

  describe "#titleize_name_and_address" do
    it "updates the attributes of the business with correct capitalization" do
      business = Fabricate(:business)
      business.name = "lower case law"
      business.community = "lower town"
      business.street_address = "lower ave"

      expect(business.name).to eq("lower case law")
      business.titleize_name_and_address
      expect(business.name).to eq("Lower Case Law")
      expect(business.community).to eq("Lower Town")
      expect(business.street_address).to eq("Lower Ave")
    end
  end

  describe "#format_postal_code" do
    let(:business) { Fabricate(:business) }

    it "removes creates a space if none provided" do
      business.postal_code = "M3M4J5"
      business.format_postal_code
      expect(business.postal_code).to eq("M3M 4J5")
    end

    it "removes unwanted hyphens or characters" do
      business.postal_code = "M-3-M_4-J-5"
      business.format_postal_code
      expect(business.postal_code).to eq("M3M 4J5")
    end
  end

  describe "#format_phone_number" do
    let(:business) { Fabricate(:business) }

    it "converts numbers into desired format" do
      business.phone_number = "3334445555"
      business.format_phone_number
      expect(business.phone_number).to eq("(333) 444-5555")
    end

    it "handles improperly formatted numbers" do
      business.phone_number = "((333))-4-4-4  5555"
      business.format_phone_number
      expect(business.phone_number).to eq("(333) 444-5555")      
    end
  end

  describe "#rating" do
    it "finds the average of the business review ratings" do
      business = Fabricate(:business)
      review1 = Fabricate(:review, business_id: business.id, rating: 4)
      review2 = Fabricate(:review, business_id: business.id, rating: 2)
      expect(business.rating).to eq(3)
    end

    it "finds a decimal average of the business review ratings" do
      business = Fabricate(:business)
      review1 = Fabricate(:review, business_id: business.id, rating: 5)
      review2 = Fabricate(:review, business_id: business.id, rating: 2)
      expect(business.rating).to eq(3.5)      
    end
  end
end
