require 'rails_helper'

describe BusinessesController, type: :controller do
  describe 'GET index' do
    it 'lists a business' do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business)
      business3 = Fabricate(:business)
      get :index
      expect(assigns(:businesses)).to eq([business1, business2, business3])
    end
  end

  describe 'GET new' do
    it 'assigns business instance variable' do
      user = Fabricate(:user)
      session[:user_id] = user.id

      get :new
      expect(assigns(:business)).to be_instance_of(Business)
    end

    it "redirects to log in page unless logged in" do 
      get :new
      expect(response).to redirect_to log_in_path
    end
  end

  describe 'POST create' do
    context "with valid inputs" do
      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "creates a new business" do
        post :create, business: { name: "Woodlot", community: "Little Italy", street_address: "293 Palmerston Avenue", postal_code: "M6J 2J3", phone_number: "6473426307", price_range: 3 }
        expect(Business.count).to eq(1)
      end
      it "redirects to business show page"
    end
    context "with invalid inputs" do
      before do
        session[:user_id] = Fabricate(:user).id
        post :create, business: { name: "", community: "Little Italy", street_address: "293 Palmerston Avenue", postal_code: "M6J 2J3", phone_number: "6473426307", price_range: 3 }
        
      end

      it "renders new page" do
        expect(response).to render_template :new
      end

      it "displays flash error" do
        expect(flash[:error]).not_to be_nil
      end
    end

    context "unauthenticated user" do
      it "redirects to log in page" do
        post :create, business: { name: "Woodlot", community: "Little Italy", street_address: "293 Palmerston Avenue", postal_code: "M6J 2J3", phone_number: "6473426307", price_range: 3 }
        expect(response).to redirect_to log_in_path
      end
    end
  end

  describe 'GET show' do
    it "assigns business instance variable" do
      business = Fabricate(:business)
      get :show, id: business.id
      expect(assigns(:business)).to eq(business)
    end
  end
end