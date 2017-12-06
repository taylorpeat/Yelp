require 'spec_helper'

feature "user registers business and creates review" do
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

    select "3.5 Stars", from: "review[rating]"
    fill_in "review[content]", with: "This restaurant was above average."
    click_button "Post Review"

    expect(page).to have_content "This restaurant was above average."
    expect(page).to have_css ".i-stars--regular-3-half"

    select "2 Stars", from: "review[rating]"
    fill_in "review[content]", with: "This restaurant was below average."
    click_button "Post Review"

    expect(page).not_to have_content "This restaurant was below average."
    expect(page).not_to have_css ".i-stars--regular-2"
    expect(page).to have_content "The review could not be saved"
  end

  scenario "with invalid inputs" do
    sign_in_user

    visit new_business_path

    fill_in "business[name]", with: ""
    fill_in "business[community]", with: "Harbourfront"
    fill_in "business[street_address]", with: "107 Queen's Quay W."
    fill_in "business[postal_code]", with: "M5V4B2"
    fill_in "business[phone_number]", with: "3334445555"
    fill_in "tags", with: "Chinese, Buffet"
    select "$$$", from: "business[price_range]"
    click_button "Register Business"

    expect(page).to have_content("You must enter a valid business name and address.")
    expect(page).to have_content("Register your business on Yelp")
  end
end