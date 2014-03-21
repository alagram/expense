require 'spec_helper'

describe ShoppingList do
  it { should belong_to(:user) }
end
