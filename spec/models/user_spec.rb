require 'rails_helper'

describe User, type: :model do
  describe "#display_name" do
    it "returns first and first letter of last name" do
      user = Fabricate(:user, first_name: "Bill", last_name: "Gates")
      expect(user.display_name).to eq("Bill G.")
    end
  end
end