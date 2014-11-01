class Item < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user

  validates_presence_of :name, :price, :quantity
  validates :price, numericality: { greater_than: 0 }, format: { with: /^\d{1,6}(\.\d{0,2})?$/, multiline: true }
  validates_numericality_of :quantity, greater_than: 0, only_integer: true
  validate :purchased_at_cannot_be_in_the_future

  def self.search(start_date, end_date)
    where("purchased_at::date >= ? AND purchased_at::date <= ?", start_date, end_date).order("purchased_at DESC")
  end

  def total
    self.price * self.quantity
  end

  def purchased_at_cannot_be_in_the_future
    if purchased_at.present? && purchased_at > Date.today
      errors[:base] << "Purchase date cannot be in the future."
    end
  end

  def shop_name
    shop.try(:name)
  end

  def shop_name=(name)
    self.shop = Shop.find_or_create_by_name(name) if name.present?
  end
end
