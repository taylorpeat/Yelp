require 'spec_helper'

describe SessionsController, type: :controller do
  describe "GET new" do
    it "redirects to business index if logged in" do
      get :new
    end
    
    it "doesn't redirect if not logged in"
  end
end