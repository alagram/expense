class Item < ActiveRecord::Base
  belongs_to :shop

  validates_presence_of :name, :price

  attr_accessor :new_shop
end
