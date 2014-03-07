require 'spec_helper'

describe ItemsController do
  describe "GET new" do
    it "sets the @item instance variable" do
      set_current_user
      get :new
      expect(assigns(:item)).to be_new_record
      expect(assigns(:item)).to be_instance_of(Item)
    end
  end

  describe "GET index" do
    it "sets the @items instance variable" do
      set_current_user
      shop = Fabricate(:shop)
      egg = Fabricate(:item, shop_id: shop.id)
      milk = Fabricate(:item, shop_id: shop.id)
      get :index
      expect(assigns(:items)).to match_array([egg, milk])
    end
  end

  describe "POST create" do

    before { set_current_user }

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
      it "creates a shop and associtiates it with item if shop name is entered" do
        post :create, item: Fabricate.attributes_for(:item, new_shop: "Koala")
        expect(Item.first.shop_name).to eq("Koala")
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

  describe "GET search" do

    before { set_current_user }

    context "with valid attributes" do
      it "sets @results instance variable" do
        item1 = Fabricate(:item, created_at: 1.month.ago)
        item2 = Fabricate(:item)
        get :search, s: "2014-01-01", e: "#{Date.today}"
        expect(assigns(:results)).to match_array([item2, item1])
      end
    end

    context "with invalid attributes" do

      before do
        item1 = Fabricate(:item, created_at: 1.month.ago)
        item2 = Fabricate(:item)
      end

      it "does not set @ results instance variable" do
        get :search, s: "", e: ""
        expect(assigns(:results)).to be_nil
      end
      it "redirects to the find page with empty params" do
        get :search, s: "", e: nil
        expect(response).to redirect_to find_path
      end
      it "redirects to the find page with an invalid date" do
        get :search, s: "2014-01-", e: "#{Date.today}"
        expect(response).to redirect_to find_path
      end
      it "sets flash error message" do
        get :search, s: "", e: ""
        expect(flash[:danger]).to be_present
      end
    end
  end
end
