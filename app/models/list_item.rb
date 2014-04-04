class ListItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :list

  validates_presence_of :name
  validates :name, uniqueness: { message: "Sorry, item is already on the list." }
end
