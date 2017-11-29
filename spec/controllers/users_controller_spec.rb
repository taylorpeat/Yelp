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
      it "creates a new user" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end

      it "redirects to businesses" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to businesses_path
      end

      it "logs user into session" do
        user = Fabricate(:user)
        post :create, user: { first_name: user.first_name, last_name: user.last_name, email: user.email, password: "password" }
        expect(session[:user_id]).not_to be_nil
      end
    end

    context "with invalid input" do
      before do
        post :create, user: { first_name: "", last_name: "Smith", email: "example@example.com", password: "password" }
      end

      it "renders new template" do
        expect(response).to render_template :new
      end

      it "assigns user instance variable" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "shows flash error" do
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end
