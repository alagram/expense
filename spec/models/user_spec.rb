require 'spec_helper'

describe User do
  it { should have_many(:items) }
  it { should have_secure_password }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:password).on(:create) }
  it { should ensure_length_of(:username).is_at_least(3).is_at_most(20) }
  it { should ensure_length_of(:password).is_at_least(5).is_at_most(20) }
end
