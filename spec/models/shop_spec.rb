require 'spec_helper'

describe Shop do
  it { should have_many(:items) }
end
