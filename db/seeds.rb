puts "Cleaning database..."
Property.destroy_all

puts "Creating properties..."
Property.create!(
  title: 'Luxury Beachfront Villa',
  description: 'Beautiful villa with ocean views',
  property_type: 'Villa',
  price_per_night: 299.99,
  cleaning_fee: 50,
  service_fee: 25,
  max_guests: 6,
  bedrooms: 3,
  beds: 4,
  bathrooms: 2,
  address: '123 Beach Road',
  city: 'Miami',
  state: 'Florida',
  country: 'USA',
  zip_code: '33139',
  latitude: 25.7617,
  longitude: -80.1918,
  active: true,
  approved: true
)

puts "Finished!"
