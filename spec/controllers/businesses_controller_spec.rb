require 'rails_helper'

describe BusinessesController, type: :controller do
  describe "GET index" do
    let(:business1) { Fabricate(:business) }
    let(:business2) { Fabricate(:business) }
    let(:business3) { Fabricate(:business) }

    before do
      get :index
    end

    it "lists a business" do
      expect(assigns(:businesses)).to contain_exactly(business1, business2, business3)
    end

    it "lists businesses in descending order of created_at" do
      business1.created_at = Time.now - 2.days
      business2.created_at = Time.now - 1.day
      business3.created_at = Time.now

      expect(assigns(:businesses)).to eq([business3, business2, business1])
    end
  end

  describe "GET new" do
    it "assigns business instance variable" do
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

  describe "POST create" do
    context "with valid inputs" do
      before do
        session[:user_id] = Fabricate(:user).id
        post :create, business: { name: "Woodlot", community: "Little Italy", street_address: "293 Palmerston Avenue", postal_code: "M6J 2J3", phone_number: "6473426307", price_range: 3 }, tags: ""
      end

      it "creates a new business" do
        expect(Business.count).to eq(1)
      end

      it "redirects to business show page" do
        expect(response).to redirect_to business_path(Business.first.id)
      end
    end

    context "with invalid inputs" do
      before do
        session[:user_id] = Fabricate(:user).id
        post :create, business: { name: "", community: "Little Italy", street_address: "293 Palmerston Avenue", postal_code: "M6J 2J3", phone_number: "6473426307", price_range: 3 }, tags: ""
      end

      it "renders new page" do
        expect(response).to render_template :new
      end

      it "displays flash error" do
        expect(flash[:error]).not_to be_nil
      end
    end

    it "redirects to log in page" do
      post :create, business: { name: "Woodlot", community: "Little Italy", street_address: "293 Palmerston Avenue", postal_code: "M6J 2J3", phone_number: "6473426307", price_range: 3 }, tags: ""
      expect(response).to redirect_to log_in_path
    end
  end

  describe 'GET show' do
    it "assigns business instance variable" do
      user = Fabricate(:user)
      business = Fabricate(:business, user_id: user.id)
      get :show, id: business.id
      expect(assigns(:business)).to eq(business)
    end
  end

  describe 'GET search' do
    it 'assigns businesses instance variable' do
      user = Fabricate(:user)
      business1 = Fabricate(:business, name: "Food Truck", user_id: user.id)
      get :search, query: "Truck"
      expect(assigns(:businesses).first).to eq(Business.first)
    end
  end
end