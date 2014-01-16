require 'spec_helper'

describe Item do
 it { should belong_to(:shop) }
 it { should validate_presence_of(:name) }
 it { should validate_presence_of(:price) }
end