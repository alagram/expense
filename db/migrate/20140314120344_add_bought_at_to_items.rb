class AddBoughtAtToItems < ActiveRecord::Migration
  def change
    add_column :items, :bought_at, :datetime
  end
end
