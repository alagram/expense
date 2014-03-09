Fabricator(:item) do
  name { Faker::Lorem.word.capitalize }
  price { rand(1..200) }
  description { Faker::Lorem.words(3).join(" ") }
end
