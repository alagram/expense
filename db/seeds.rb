# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
alice = User.create(username: "alice", password: "12345")
joe = User.create(username: "joe", password: "abc321")
john = User.create(username: "john", password: "123abc")
koala = Shop.create(name: "Koala")
shoprite = Shop.create(name: "Shoprite")
marina = Shop.create(name: "Marina Mall")
game = Shop.create(name: "Game")
salinesta = Shop.create(name: "Salinesta")

Shop.all.each do |shop|
  3.times { Fabricate(:item, shop_id: shop.id, user: alice) }
  2.times { Fabricate(:item, shop_id: shop.id, user: joe) }
  4.times { Fabricate(:item, shop_id: shop.id, user: john) }
end
