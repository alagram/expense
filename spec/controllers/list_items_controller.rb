require 'spec_helper'

describe ListItemsController do
  describe "POST create" do
    context "with authenticated users" do

      context "with valid attributes" do

        it "redirects to list_list_items page" do
          set_current_user
          list = Fabricate(:list)
          post :create, list_item: Fabricate.attributes_for(:list_item, name: "My List"), list_id: list.id
          expect(response).to redirect_to list_list_items_path
        end
        it "create a new list item" do
          set_current_user
          list = Fabricate(:list)
          post :create, list_item: Fabricate.attributes_for(:list_item, name: "My List"), list_id: list.id
          expect(ListItem.count).to eq(1)
        end
        it "create a list item associtaed with current logged in user" do
          set_current_user
          alice = current_user
          list = Fabricate(:list)
          post :create, list_item: Fabricate.attributes_for(:list_item, name: "My List"), list_id: list.id
          expect(ListItem.first.user).to eq(alice)
        end
        it "dislays success message" do
          set_current_user
          list = Fabricate(:list)
          post :create, list_item: Fabricate.attributes_for(:list_item, name: "My List"), list_id: list.id
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid attributes"
    end

    context "with unauthenticated users"
  end
end
