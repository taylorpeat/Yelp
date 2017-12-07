require 'rails_helper'

describe UsersController, :type => :controller do
  describe "GET new" do
    it "assigns user instance variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end
      
      it "creates a new user" do
        expect(User.count).to eq(1)
      end

      it "redirects to businesses" do
        expect(response).to redirect_to businesses_path
      end

      it "logs user into session" do
        expect(session[:user_id]).not_to be_nil
      end
    end

    context "with invalid input" do
      before do
        post :create, user: { first_name: "", last_name: "Smith", email: "example@example.com", password: "password" }
      end

      it "renders new template" do
        expect(response).to redirect_to register_path
      end

      it "assigns user instance variable" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "shows flash error" do
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  describe "GET show" do
    it "assigns user instance variable" do
      user = Fabricate(:user)
      get :show, id: user.id
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
end
