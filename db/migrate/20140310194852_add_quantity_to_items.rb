class AddQuantityToItems < ActiveRecord::Migration
  def change
    add_column :items, :quantity, :string
  end
end
