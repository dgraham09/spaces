# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"
puts 'Creating 50 fake spaces'
50.times do
  user = User.new(email: Faker::Internet.email, password: "123456")
  user.save!

  space = Space.new(name: Faker::Address.community, address: Faker::Address.full_address, price: rand(80.01..900.99), user: user)
  space.save!
end
puts 'Finished!'
