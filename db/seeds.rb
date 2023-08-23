# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"
require "open-uri"


puts 'Creating 25 fake spaces'
User.destroy_all
Booking.destroy_all
Space.destroy_all

25.times do
  user = User.new(email: Faker::Internet.email, password: "123456")
  user.save!

  # url = "https://api.unsplash.com/photos/random?client_id=#{ENV["ACCESS_KEY"]}&query=desk"
  # photo_serialized = URI.open(url).read
  # photo_json = JSON.parse(photo_serialized)
  # photo_url = photo_json["urls"]["small"]

  streets_paris = [
    "Champs-Élysées",
    "Avenue Montaigne",
    "Rue de Rivoli",
    "Boulevard Saint-Germain",
    "Rue du Faubourg Saint-Honoré",
    "Rue de la Paix",
    "Boulevard Haussmann",
    "Rue Saint-Antoine",
    "Rue de la Bastille",
    "Rue des Martyrs",
    "Avenue des Champs-Élysées",
    "Rue de la Roquette",
    "Rue de la Pompe",
    "Quai de Conti",
    "Rue de la Madeleine",
    "Villa Gaudelet"
  ]

  # file = URI.open(photo_url)
  space = Space.new(name: Faker::Address.community, address: "#{rand(1..5)} #{streets_paris.sample}, Paris" , price: rand(80.01..900.99), rating: rand(1..5), user: user)
  # space.photo.attach(io: file, filename: "desk.png", content_type: "image/png")
  space.save!

  end

  user = User.new(email: "maxxx@gmail.com", password: "123456")
  user.save!
  space_max = Space.new(name: "Max's Castle", address: "Gran Via de les Corts Catalanes, 540, 08011 Barcelona, Spain", price: 88, user: user)
  space_max.save!

  user = User.new(email: "davidos@gmail.com", password: "123456")
  user.save!
  booking = Booking.new(booking_start_date: Date.today - 6.days, booking_end_date: Date.today - 4.days, user: user, space: space_max)
  booking.save!

  user = User.new(email: "malinuxmagician@gmail.com", password: "123456")
  user.save!
  space = Space.new(name: "Park residence", address: "163 Av. de Suffren, 75015 Paris", price: 90, user: user)
  space.save!
  booking = Booking.new(booking_start_date: Date.today - 23.days, booking_end_date: Date.today - 10.days, user: user, space: space_max)
  booking.save!
  booking = Booking.new(booking_start_date: Date.today - 60.days, booking_end_date: Date.today - 56.days, user: user, space: space_max)
  booking.save!

puts 'Finished!'
