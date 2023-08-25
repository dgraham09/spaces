require "faker"
require "open-uri"

url = "https://api.unsplash.com/photos/random?client_id=#{ENV["ACCESS_KEY"]}&query=desk"

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

puts 'Destroying database ...'
User.destroy_all
Booking.destroy_all
Space.destroy_all

puts 'Creating 18 fake users ...'

18.times do
  user = User.new(
    email: Faker::Internet.email,
    password: "123456",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  user.save!
end

puts 'Creating 9 fake spaces with 9 random Users as Owners...'

Owners = User.all.sample(9)

Owners.each do |owner|
  space = Space.new(
    user: owner,
    name: Faker::Address.community,
    address: "#{rand(1..5)} #{streets_paris.sample}, Paris",
    price: rand(30.01..300.99),
    rating: rand(1..5),
    capacity: rand(2..20)
  )
  # photo_serialized = URI.open(url).read
  # photo_json = JSON.parse(photo_serialized)
  # photo_url = photo_json["urls"]["small"]
  # file = URI.open(photo_url)
  # space.photo.attach(io: file, filename: "desk.png", content_type: "image/png")
  space.save!
end

puts 'Creating 18 fake bookings, 2 for each space, with a random User Customer'
puts 'No overlapping dates'

Space.all.each do |space|
  # For each space create 2 bookings:
  Booking.create(
    space: space,
    user: User.all.sample,
    booking_start_date: Date.new(2023, 8, 24),
    booking_end_date: Date.new(2023, 9, 4)
  )
  Booking.create(
    space: space,
    user: User.all.sample,
    booking_start_date: Date.new(2023, 9, 21),
    booking_end_date: Date.new(2023, 9, 26)
  )
end

puts "Seeding super users Davidos, Max and Malin ..."

user = User.create(email: "maxxx@gmail.com", password: "123456", first_name: "Max")
space_max = Space.create(
  name: "Max's Castle",
  address: "Gran Via de les Corts Catalanes, 540, 08011 Barcelona, Spain",
  price: 88,
  capacity: 12,
  rating: 4,
  user: user
)

user = User.create(email: "davidos@gmail.com", password: "123456", first_name: "Davidos")
Booking.create(
  space: space_max,
  user: user,
  booking_start_date: Date.new(2023, 8, 19),
  booking_end_date: Date.new(2023, 8, 24)
)

user = User.create(email: "malinuxmagician@gmail.com", password: "123456", first_name: "Malin")
Space.create(
  name: "Malin's Cave",
  address: "163 Av. de Suffren, 75015 Paris",
  price: 90,
  capacity: 8,
  rating: 3,
  user: user
)
Booking.create(
  space: space_max,
  user: user,
  booking_start_date: Date.new(2023, 8, 26),
  booking_end_date: Date.new(2023, 9, 5)
)

Booking.create(
  space: space_max,
  user: user,
  booking_start_date: Date.new(2023, 9, 10),
  booking_end_date: Date.new(2023, 9, 14)
)

puts 'Seed Finished!'
