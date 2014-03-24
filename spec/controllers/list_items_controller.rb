require 'spec_helper'

describe ListItemsController do
  describe "POST create" do
    context "with authenticated users" do

      context "with valid attributes" do

        it "redirects to list show page" do
          set_current_user
          list = Fabricate(:list)
          post :create, list_item: Fabricate.attributes_for(:list_item, name: "My List"), list_id: list.id
          expect(response).to redirect_to list
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

      context "with invalid attributes" do
        it "does not create a list item" do
          set_current_user
          list = Fabricate(:list)
          post :create, list_item: Fabricate.attributes_for(:list_item, name: nil), list_id: list.id
          expect(ListItem.count).to eq(0)
        end
        it "sets @list" do
          set_current_user
          list = Fabricate(:list)
          post :create, list_item: Fabricate.attributes_for(:list_item, name: nil), list_id: list.id
          expect(assigns(:list)).to be_present
        end
        it "sets @list_items" do
          set_current_user
          list = Fabricate(:list)
          list_item = Fabricate(:list_item, list: list)
          post :create, list_item: Fabricate.attributes_for(:list_item, name: nil), list_id: list.id
          expect(assigns(:list_items)).to match_array([list_item])
        end
        it "renders lists show page" do
          set_current_user
          list = Fabricate(:list)
          list_item = Fabricate(:list_item, list: list)
          post :create, list_item: Fabricate.attributes_for(:list_item, name: nil), list_id: list.id
          expect(response).to render_template 'lists/show'
        end
      end
    end

    context "with unauthenticated users" do
      it "redirects to sign in page" do
        list = Fabricate(:list)
        post :create, list_item: Fabricate.attributes_for(:list_item, name: "My List"), list_id: list.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "DELETE destroy" do
    context "with authenticated users" do
      it "redirects to list show page" do
        set_current_user
        list = Fabricate(:list)
        list_item = Fabricate(:list_item)
        delete :destroy, list_id: list.id, id: list_item.id
        expect(response).to redirect_to list
      end
      it "sets @list_item" do
        set_current_user
        list = Fabricate(:list)
        list_item = Fabricate(:list_item)
        delete :destroy, id: list_item.id, list_id: list.id
        expect(assigns(:list_item)).to be_present
      end
      it "deletes a list item" do
        set_current_user
        alice = current_user
        list = Fabricate(:list, user: alice)
        list_item = Fabricate(:list_item, user: alice)
        delete :destroy, id: list_item.id, list_id: list.id
        expect(ListItem.count).to eq(0)
      end
    end

    context "with unauthenticated users" do
      it "redirects to sign in page" do
        list = Fabricate(:list)
        list_item = Fabricate(:list_item)
        delete :destroy, id: list_item.id, list_id: list.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
