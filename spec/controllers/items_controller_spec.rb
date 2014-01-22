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
        shop = Fabricate(:shop)
        post :create, item: Fabricate.attributes_for(:item, shop_id: shop.id)
        expect(response).to redirect_to new_item_path
      end
      it "creates a new item" do
        shop = Fabricate(:shop)
        post :create, item: Fabricate.attributes_for(:item, shop_id: shop.id)
        expect(Item.count).to eq(1)
      end
      it "it creates an item associated with a shop" do
        shop = Fabricate(:shop)
        post :create, item: Fabricate.attributes_for(:item, shop_id: shop.id)
        expect(Item.first.shop).to eq(shop)
      end
      it "sets the flash success message" do
        shop = Fabricate(:shop)
        post :create, item: Fabricate.attributes_for(:item, shop_id: shop.id)
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid attributes" do
      it "renders the new template" do
        post :create, item: Fabricate.attributes_for(:item, name: nil)
        expect(response).to render_template :new
      end
      it "it does not create an item" do
        post :create, item: Fabricate.attributes_for(:item, price: nil)
        expect(Item.count).to eq(0)
      end
    end
  end
end
