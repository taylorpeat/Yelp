require 'spec_helper'

feature "user creates new business" do
  scenario "with valid inputs" do
    sign_in_user

    visit new_business_path

    fill_in "business[name]", with: "The Pearl"
    fill_in "business[community]", with: "Harbourfront"
    fill_in "business[street_address]", with: "107 Queen's Quay W."
    fill_in "business[postal_code]", with: "M5V4B2"
    fill_in "business[phone_number]", with: "3334445555"
    fill_in "tags", with: "Chinese, Buffet"
    select "$$$", from: "business[price_range]"
    click_button "Register Business"

    expect(page).to have_content "The Pearl"
    expect(page).to have_content "$$$"
    expect(page).to have_content "Chinese" 
  end
end