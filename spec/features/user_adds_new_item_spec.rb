require 'spec_helper'

feature "User adds new item" do

  scenario "with valid attributes" do
    alice = Fabricate(:user)
    visit root_path
    sign_in(alice)
    click_link "ADD ITEM"
    fill_in_valid_values
    expect(page).to have_content "Item successfully added."
  end

  scenario "with invalid attributes" do
    alice = Fabricate(:user)
    visit root_path
    sign_in(alice)
    click_link "ADD ITEM"
    fill_in_invalid_values
    expect(page).to have_content "Price is invalid"
  end

  private

  def fill_in_valid_values
    fill_in "item_name", with: "Eggs"
    fill_in "item_description", with: "2 Crates of Eggs"
    fill_in "item_price", with: "23.00"
    fill_in "item_quantity", with: 2
    fill_in "item_new_shop", with: "Faith Way Shop"
    click_button "Add Item"
  end

  def fill_in_invalid_values
    fill_in "item_name", with: "Milk"
    fill_in "item_description", with: "1 gallon"
    fill_in "item_price", with: nil
    click_button "Add Item"
  end

end
