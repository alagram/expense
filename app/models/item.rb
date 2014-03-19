class Item < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user

  validates_presence_of :name, :price, :quantity
  validates_presence_of :shop_id, if: -> { new_shop_blank? }
  validates :price, numericality: true, format: { with: /^\d{1,6}(\.\d{0,2})?$/, multiline: true }
  validates_numericality_of :quantity, greater_than: 0, only_integer: true
  validate :purchased_at_cannot_be_in_the_future

  attr_accessor :new_shop
  before_save :create_shop

  delegate :name, to: :shop, prefix: true

  def self.search(start_date, end_date)
    where("created_at::date >= ? AND created_at::date <= ?", start_date, end_date).order("created_at DESC")
  end

  def total
    self.price * self.quantity
  end

  def purchased_at_cannot_be_in_the_future
    if purchased_at.present? && purchased_at > Date.today
      errors[:base] << "Purchase date cannot be in the future."
    end
  end

  private

  def create_shop
    if new_shop.present? && shop_id.nil?
      self.shop = Shop.create!(name: new_shop)
    elsif new_shop.present? && shop_id.present?
      errors[:base] << "Either enter shop name or select shop."
      false
    end
  end

  def new_shop_blank?
    new_shop.blank?
  end
end
