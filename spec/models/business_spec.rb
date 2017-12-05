require 'rails_helper'

RSpec.describe Business, type: :model do
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
end
