class User < ActiveRecord::Base
  has_many :items, -> { order("purchased_at DESC") }
  has_secure_password validations: false
  has_many :lists
  has_many :shops

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_length_of :username, within: 2..20
  validates_presence_of :password, on: :create
  validates_length_of :password, within: 5..20
end
