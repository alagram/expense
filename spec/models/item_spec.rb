require 'spec_helper'

describe Item do
 it { should belong_to(:shop) }
 it { should validate_presence_of(:name) }
 it { should validate_presence_of(:price) }
 it { should validate_numericality_of(:price) }

 describe "search" do
  it "returns an array of one item for an exact match" do
    item = Fabricate(:item)
    expect(Item.search("2014-02-01", "2014-02-06")).to eq([item])
  end
 end
end
