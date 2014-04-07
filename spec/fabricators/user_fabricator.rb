Fabricator(:user) do
  username { Faker::Internet.user_name.first(20) }
  password { 'password' }
end
