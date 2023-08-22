# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"


puts 'Creating 50 fake spaces'
  User.destroy_all
  Booking.destroy_all
  Space.destroy_all

50.times do
  user = User.new(email: Faker::Internet.email, password: "123456")
  user.save!

  space = Space.new(name: Faker::Address.community, address: Faker::Address.full_address, price: rand(80.01..900.99), user: user)
  space.save!
end

  user = User.new(email: "maxxx@gmail.com", password: "123456")
  user.save!
  space_max = Space.new(name: "Max's Castle", address: "Barcelona", price: 88, user: user)
  space_max.save!

  user = User.new(email: "davidos@gmail.com", password: "123456")
  user.save!
  booking = Booking.new(booking_start_date: Date.today - 6.days, booking_end_date: Date.today - 4.days, user: user, space: space_max)
  booking.save!

  user = User.new(email: "malinuxmagician@gmail.com", password: "123456")
  user.save!
  space = Space.new(name: "Park residence", address: "Paris", price: 90, user: user)
  space.save!
  booking = Booking.new(booking_start_date: Date.today - 23.days, booking_end_date: Date.today - 10.days, user: user, space: space_max)
  booking.save!

puts 'Finished!'
