require 'spec_helper'

describe ListItem do
  it { should belong_to(:user) }
end
