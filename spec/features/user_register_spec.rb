require 'spec_helper'

feature "user signs in" do
  scenario "with valid email and password" do
    visit register_path
    fill_in "user[first_name]", with: "John"
    fill_in "user[last_name]", with: "Doe"
    fill_in "user[email]", with: "john@example.com"
    fill_in "user[password]", with: "password"
    click_button "Sign Up"
    expect(page).to have_content "JD"
    expect(page).to have_content "Log Out"
  end
end