Fabricator(:item) do
  name { Faker::Commerce.product_name }
  price { rand(1..200) }
  quantity { (1..5).to_a.sample }
  purchased_at { rand(1..30).days.ago }
  description { Faker::Lorem.words(3).join(" ") }
end
