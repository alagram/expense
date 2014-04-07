require 'spec_helper'

describe ListItem do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:list) }
  it { should validate_uniqueness_of(:name).with_message("Sorry, item is already on the list.") }
end
