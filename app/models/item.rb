class Item < ActiveRecord::Base
  belongs_to :shop

  validates_presence_of :name, :price

  attr_accessor :new_shop
  before_save :create_shop

  private

  def create_shop
    self.shop = Shop.create!(name: new_shop) if new_shop.present?
  end
end
