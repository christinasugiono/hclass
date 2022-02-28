# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user - 3
# items - 10

require 'faker'

5.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.street_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  user.save!
end

10.times do
  item = Item.new(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentences(number: 1),
    price: Faker::Commerce.price(range: 50..500),
    brand: Faker::Commerce.brand,
    category: Faker::Commerce.department,
    user_id: rand(1..5)
  )
  item.save!
end
puts 'Finished!'
