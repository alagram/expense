class RemoveLocationFromShops < ActiveRecord::Migration
  def change
    remove_column :shops, :location, :string
  end
end
