Fabricator(:shopping_list) do
  name { Faker::Lorem.word.capitalize }
end
