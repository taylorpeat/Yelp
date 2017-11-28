require 'spec_helper'

describe UsersController, :type => :controller do
  describe "GET new" do
    it "assigns user instance variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
end
