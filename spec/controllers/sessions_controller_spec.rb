require 'rails_helper'

describe SessionsController, type: :controller do
  describe "GET new" do
    it "redirects to business index if logged in" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to businesses_path
    end

    it "doesn't redirect if not logged in" do
      get :new
      expect(response).not_to redirect_to businesses_path
    end
  end

  describe "POST create" do
    context "with valid input" do
      let(:user) { Fabricate(:user) }
      
      before do
        post :create, email: user.email, password: "password"      
      end
      
      it "creates new session" do
        expect(session[:user_id]).to eq(user.id)
      end
    
      it "redirects to businesses" do
        expect(response).to redirect_to businesses_path
      end
    end

    context "without valid input" do
      let(:user) { Fabricate(:user) }
      
      before do
        post :create, email: user.email, password: "incorrect"      
      end
      
      it "doesn't create a session" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects to log in page" do
        expect(response).to redirect_to log_in_path
      end

      it "displays error message" do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    
    it "removes session" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to home page" do
      expect(response).to redirect_to home_path
    end

    it "displays message" do
      expect(flash[:success]).to be_present
    end
  end
end