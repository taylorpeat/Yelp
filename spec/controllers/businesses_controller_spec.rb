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
      get :new
      expect(assigns(:business)).to be_instance_of(Business)
    end
  end
end