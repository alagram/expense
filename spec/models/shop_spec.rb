require 'spec_helper'

describe Shop do
  it { should have_many(:items) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:user) }
end
