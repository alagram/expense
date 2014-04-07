class RenameShoppingListsTable < ActiveRecord::Migration
  def change
    rename_table :shopping_lists, :lists
  end
end
