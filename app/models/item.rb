class Item < ActiveRecord::Base
  belongs_to :shop

  validates_presence_of :name, :price
  validates :price, numericality: true, format: { with: /^\d{1,6}(\.\d{0,2})?$/, multiline: true }

  attr_accessor :new_shop
  before_save :create_shop

  delegate :name, to: :shop, prefix: true

  def self.search(start_date, end_date)
    where("created_at::date >= ? AND created_at::date <= ?", start_date, end_date)
  end

  private

  def create_shop
    self.shop = Shop.create!(name: new_shop) if new_shop.present?
  end
end
