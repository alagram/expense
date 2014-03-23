require 'spec_helper'

describe ListItem do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:list) }
end
