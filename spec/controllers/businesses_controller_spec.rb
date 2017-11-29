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
      it "creates a new business"
      it "redirects to businesses"
    end
    context "with invalid inputs" do
      
    end
  end
end