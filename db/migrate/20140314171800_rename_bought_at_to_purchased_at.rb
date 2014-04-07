class RenameBoughtAtToPurchasedAt < ActiveRecord::Migration
  def change
    rename_column :items, :bought_at, :purchased_at
  end
end
