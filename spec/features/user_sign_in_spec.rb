require 'spec_helper'

feature "user signs in" do
  scenario "with valid email and password" do
    user = Fabricate(:user)
    sign_in_user(user)
    expect(page).to have_content user.initials
  end
end