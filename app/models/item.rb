class Item < ActiveRecord::Base
  belongs_to :shop

  validates_presence_of :name, :price
  validates :price, numericality: true, format: { with: /^\d{1,6}(\.\d{0,2})?$/, multiline: true }

  attr_accessor :new_shop
  before_save :create_shop

  delegate :name, to: :shop, prefix: true

  private

  def create_shop
    self.shop = Shop.create!(name: new_shop) if new_shop.present?
  end
end
