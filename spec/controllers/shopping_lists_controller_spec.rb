require 'spec_helper'

describe ShoppingListsController do
  describe "GET new" do
    it "sets the @shopping_list instance variable" do
      get :new
      expect(assigns(:shopping_list)).to be_new_record
      expect(assigns(:shopping_list)).to be_instance_of(ShoppingList)
    end
  end

  describe "POST create" do
    context "with authenticated users" do

      before { set_current_user }

      context "with valid attributes" do

        it "redirects to shopping_lists show page" do
          post :create, shopping_list: Fabricate.attributes_for(:shopping_list)
          expect(response).to redirect_to new_shopping_list_path
        end
        it "it creates a new shopping list" do
          post :create, shopping_list: Fabricate.attributes_for(:shopping_list)
          expect(ShoppingList.count).to eq(1)
        end
        it "associates the signed in user to the shopping list" do
          alice = current_user
          post :create, shopping_list: Fabricate.attributes_for(:shopping_list)
          expect(ShoppingList.first.user).to eq(alice)
        end
        it "sets flash success message" do
          post :create, shopping_list: Fabricate.attributes_for(:shopping_list)
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid attributes" do

      end

    end

    context "with unauthenticated users"
  end
end
