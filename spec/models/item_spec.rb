require 'spec_helper'

describe Item do
 it { should belong_to(:shop) }
 it { should validate_presence_of(:name) }
 it { should validate_presence_of(:price) }
 it { should validate_presence_of(:quantity) }
 it { should validate_presence_of(:shop) }
 it { should validate_numericality_of(:price) }
 it { should belong_to(:user) }
 it { should validate_numericality_of(:quantity).is_greater_than(0) }
 it { should validate_numericality_of(:quantity).only_integer }

 describe "search" do
  it "returns an array of one item for an exact match" do
    item = Fabricate(:item)
    expect(Item.search("2014-02-01", Time.now)).to eq([item])
  end
  it "returns an array of all matches ordered by created at descending" do
    item1 = Fabricate(:item, created_at: 1.month.ago)
    item2 = Fabricate(:item, created_at: 2.weeks.ago)
    item3 = Fabricate(:item)
    expect(Item.search("2013-12-01", Time.now)).to eq([item3, item2, item1])
  end
  it "returns an empty array for a search that matches nothing" do
    item1 = Fabricate(:item, created_at: 1.month.ago)
    item2 = Fabricate(:item)
    expect(Item.search("2012-12-01", "2013-02-06")).to eq([])
  end
 end
end
