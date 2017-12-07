require 'rails_helper'

describe Review, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:business) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:business_id) }
  
  it "validate uniqueness of business_id scoped to user_id" do
    user = Fabricate(:user)
    business = Fabricate(:business)
    Fabricate(:review, user_id: user.id, business_id: business.id)
    should validate_uniqueness_of(:business_id).scoped_to(:user_id)
  end
  
  describe "#date" do
    it "formats a current time into MM/DD/YYYY string" do
      business = Fabricate(:business)
      review = Fabricate(:review, business_id: business.id)
      review.created_at = Time.new(2017, 12, 6)
      expect(review.date).to eq("12/06/2017")
    end
  end
end
