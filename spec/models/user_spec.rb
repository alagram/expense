require 'spec_helper'

describe User do
  it { should have_many(:items) }
  it { should have_secure_password }
end
