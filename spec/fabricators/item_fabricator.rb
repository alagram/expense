Fabricator(:item) do
  name { Faker::Lorem.word.capitalize }
  price 9.99
end
