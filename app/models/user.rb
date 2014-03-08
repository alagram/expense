class User < ActiveRecord::Base
  has_many :items
  has_secure_password validations: false

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_length_of :username, within: 2..20
  validates_presence_of :password, on: :create
  validates_length_of :password, within: 5..20
end
