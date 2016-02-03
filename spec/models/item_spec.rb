require 'spec_helper'

describe Item do
 it { should belong_to(:shop) }
 it { should validate_presence_of(:name) }
 it { should validate_presence_of(:price) }
 it { should validate_presence_of(:quantity) }
 it { should validate_numericality_of(:price) }
 it { should belong_to(:user) }
 it { should validate_numericality_of(:quantity).is_greater_than(0) }
 it { should validate_numericality_of(:quantity).only_integer }
 it { should validate_numericality_of(:price).is_greater_than(0) }

 describe "search" do

  let!(:shop) { Fabricate(:shop) }

  it "returns an array of one item for an exact match" do
    item = Fabricate(:item, purchased_at: 2.weeks.ago, shop: shop)
    # binding.pry
    expect(Item.search("2014-02-01", Time.now)).to eq([item])
  end
  it "returns an array of all matches ordered by purchased at descending" do
    item1 = Fabricate(:item, purchased_at: 1.month.ago, shop: shop)
    item2 = Fabricate(:item, purchased_at: 2.weeks.ago, shop: shop)
    item3 = Fabricate(:item, purchased_at: 1.week.ago, shop: shop)
    expect(Item.search("2014-01-01", 2.weeks.ago)).to eq([item2, item1])
  end
  it "returns an empty array for a search that matches nothing" do
    item1 = Fabricate(:item, purchased_at: 1.month.ago, shop: shop)
    item2 = Fabricate(:item, purchased_at: 1.week.ago, shop: shop)
    expect(Item.search("2012-12-01", "2013-02-06")).to eq([])
  end
 end
end
