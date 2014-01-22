require 'spec_helper'

describe ItemsController do
  describe "GET new" do
    it "sets the @item instance variable" do
      get :new
      expect(assigns(:item)).to be_new_record
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "redirects to the new item page" do
        post :create, item: Fabricate.attributes_for(:item)
        expect(response).to redirect_to new_item_path
      end
      it "creates a new item" do
        post :create, item: Fabricate.attributes_for(:item)
        expect(Item.count).to eq(1)
      end
      it "it creates an item associated with a shop" do
        post :create, item: Fabricate.attributes_for(:item)
        expect(Item.first.shop).to eq(Shop.first)
      end
      it "sets the flash success message" do
        post :create, item: Fabricate.attributes_for(:item)
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid attributes"
  end
end
