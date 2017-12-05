require 'rails_helper'

describe ReviewsController, type: :controller do
  describe "POST create" do
    let(:user) { Fabricate(:user) }
    let(:business) { Fabricate(:business) }
    context "with valid inputs" do
      before do
        session[:user_id] = user.id
        post :create, business_id: business.id, review: { content: "This was a great restaurant.", rating: "4.5", user: user, business: business }
      end

      it "creates new review" do
        expect(Review.count).to eq(1)
      end

      it "associates review with current user" do
        expect(Review.first.business).to eq(business)
      end

      it "associates review with correct video" do
        expect(Review.first.user).to eq(user)
      end

      it "redirects to video page" do
        expect(response).to redirect_to business_path(business.id)
      end

      it "handles half points on reviews" do
        expect(Review.first.rating).to eq(4.5)
      end
    end

    context "with invalid inputs" do
      before do
        session[:user_id] = user.id
        post :create, business_id: business.id, review: { content: "", rating: "5", user: user, business: business }
      end

      it "does not create a review" do
        expect(Review.count).to eq(0)
      end

      it "refreshes business page" do
        expect(response).to redirect_to business_path(business.id)
      end

      it "displays an error message" do
        expect(flash[:error]).not_to be_nil
      end
    end
    
    context "unauthenticated user" do
      before do
        post :create, business_id: business.id, review: { content: "This was a great restaurant.", rating: "5", user: user, business: business }
      end

      it "doesn't create a review" do
        expect(Review.count).to eq(0)
      end

      it "redirects unauthenticated users to log in page" do
        expect(response).to redirect_to log_in_path
      end

    end
  end
end