class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_items, dependent: :delete_all

  validates_presence_of :name
end
