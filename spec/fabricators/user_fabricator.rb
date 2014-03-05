Fabricator(:user) do
  username { Faker::Lorem.words(2).join }
  password { 'password' }
end
