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
      shop = Fabricate(:shop)
      set_current_user
      alice = current_user
      egg = Fabricate(:item, user: alice, shop: shop)
      milk = Fabricate(:item, user: alice, shop: shop)
      get :index
      expect(assigns(:items)).to match_array([egg, milk])
    end
  end

  describe "POST create" do

    before { set_current_user }

    context "with valid attributes and shop_id" do

      let!(:shop) { Fabricate(:shop) }

      before do
        post :create, item: Fabricate.attributes_for(:item, shop_id: shop.id)
      end

      it "redirects to the new item page" do
        expect(response).to redirect_to new_item_path
      end
      it "creates a new item" do
        expect(Item.count).to eq(1)
      end
      it "creates a new item associated with signed in user" do
        alice = current_user
        expect(Item.first.user).to eq(alice)
      end
      it "it creates an item associated with a shop" do
        expect(Item.first.shop).to eq(shop)
      end
      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with valid attributes and new_shop" do
      it "creates a shop and associtiates it with item if shop name is entered" do
        post :create, item: Fabricate.attributes_for(:item, shop_id: nil, new_shop: "Koala")
        expect(Item.first.shop_name).to eq("Koala")
      end
      it "does not associtiate a shop to an item if both shop name and shop_id are entered" do
        shop = Fabricate(:shop)
        post :create, item: Fabricate.attributes_for(:item, shop_id: shop.id, new_shop: "Bar Shop")
        expect(Item.count).to eq(0)
      end
      it "does not create a shop if shop already exist" do
        shop = Fabricate(:shop, name: "Game")
        post :create, item: Fabricate.attributes_for(:item, shop_id: nil, new_shop: "Game")
        expect(Item.count).to eq(0)
        expect(Shop.count).to eq(1)
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
      it "does not create an item if shop_id and new_shop are absent" do
        post :create, item: Fabricate.attributes_for(:item, new_shop: nil, shop_id: nil)
        expect(Item.count).to eq(0)
      end
    end
  end

  describe "GET search" do

    before { set_current_user }
    let!(:shop) { Fabricate(:shop) }

    context "with valid attributes" do
      it "sets @results instance variable" do
        alice = current_user
        item1 = Fabricate(:item, user: alice, purchased_at: 1.month.ago, shop: shop)
        item2 = Fabricate(:item, user: alice, purchased_at: 2.weeks.ago, shop: shop)
        get :search, s: "2014-01-01", e: "#{Date.today}"
        expect(assigns(:results)).to match_array([item2, item1])
      end
      it "filter's the results based on current user's items" do
        alice = current_user
        item1 = Fabricate(:item, user: alice, purchased_at: 1.month.ago, shop: shop)
        item2 = Fabricate(:item, user: alice, purchased_at: 2.weeks.ago, shop: shop)
        get :search, s: "2014-01-01", e: "#{Date.today}"
        expect(assigns(:results).all? { |item| item.user_id == alice.id }).to be_truthy
      end
    end

    context "with invalid attributes" do

      before do
        shop = Fabricate(:shop)
        item1 = Fabricate(:item, purchased_at: 1.month.ago, shop: shop)
        item2 = Fabricate(:item, purchased_at: 1.week.ago, shop: shop)
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
