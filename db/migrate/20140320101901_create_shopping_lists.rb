class CreateShoppingLists < ActiveRecord::Migration
  def change
    create_table :shopping_lists do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
