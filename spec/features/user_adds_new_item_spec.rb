require 'spec_helper'

feature "User adds new item" do
  scenario "with valid attributes" do
    visit root_path
    click_link "Add Item"
    fill_in "item_name", with: "Eggs"
    fill_in "item_description", with: "2 Crates of Eggs"
    fill_in "item_price", with: "23.00"
    fill_in "item_new_shop", with: "Faith Way Shop"
    click_button "Add Item"
    expect(page).to have_content "Item successfully added."
  end

  scenario "with invalid attributes" do

  end
end
