class Item < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user

  validates_presence_of :name, :price
  validates :price, numericality: true, format: { with: /^\d{1,6}(\.\d{0,2})?$/, multiline: true }
  validates_numericality_of :quantity, greater_than: 0, only_integer: true

  attr_accessor :new_shop
  before_save :create_shop

  delegate :name, to: :shop, prefix: true

  def self.search(start_date, end_date)
    where("created_at::date >= ? AND created_at::date <= ?", start_date, end_date).order("created_at DESC")
  end

  private

  def create_shop
    self.shop = Shop.create!(name: new_shop) if new_shop.present?
  end
end
