Fabricator(:item) do
  name { Faker::Lorem.word.capitalize }
  price { rand(1..200) }
  quantity { (1..5).to_a.sample }
  bought_at { rand(3.years).ago }
  description { Faker::Lorem.words(3).join(" ") }
  shop
end
