require 'rails_helper'

describe User, type: :model do
  it { should have_many(:businesses) }
  it { should have_many(:reviews).order("created_at desc") }
  it { should have_secure_password }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }


  describe "#display_name" do
    it "returns first and first letter of last name" do
      user = Fabricate(:user, first_name: "Bill", last_name: "Gates")
      expect(user.display_name).to eq("Bill G.")
    end
  end

  describe "#initials" do
    it "returns first and last initials of user name" do
      user = Fabricate(:user, first_name: "Bill", last_name: "Gates")
      expect(user.initials).to eq("BG")      
    end
  end
end