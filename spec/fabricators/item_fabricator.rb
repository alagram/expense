Fabricator(:item) do
  name { Faker::Lorem.word.capitalize }
  price 9.99
  description { Faker::Lorem.words(3).join(" ") }
end
