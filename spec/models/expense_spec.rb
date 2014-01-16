require 'spec_helper'

describe Item do
 it { should have_many(:stores) }
end
