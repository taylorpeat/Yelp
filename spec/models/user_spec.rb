require 'rails_helper'

describe User, type: :model do
  describe "#full_name" do
    it "returns first and last name" do
      user = Fabricate(:user, first_name: "Bill", last_name: "Gates")
      expect(user.full_name).to eq("Bill Gates")
    end
  end
end