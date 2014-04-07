class RenameShoppingListItemsTable < ActiveRecord::Migration
  def change
    rename_table :shopping_list_items, :list_items
  end
end
