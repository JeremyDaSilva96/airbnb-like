require 'faker'

puts "Cleaning database..."
Property.destroy_all

puts "Creating properties..."

# Property types with weighted options
property_types = [
  'Apartment', 'Apartment', 'House', 'House', 'Villa',
  'Loft', 'Studio', 'Penthouse', 'Cottage', 'Chalet'
]

# Create 12 random properties
12.times do |i|
  property = Property.new(
    title: "#{Faker::Address.community} #{property_types.sample}",
    description: "#{Faker::Lorem.paragraph(sentence_count: 3)} #{Faker::Lorem.paragraph(sentence_count: 2)}",
    property_type: property_types.sample,
    price_per_night: rand(80..2500),
    cleaning_fee: rand(40..250),
    service_fee: rand(25..200),
    max_guests: rand(2..10),
    bedrooms: rand(1..6),
    beds: rand(1..8),
    bathrooms: rand(1..4),
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    zip_code: Faker::Address.zip_code,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    active: true,
    approved: [true, true, true, false].sample # 75% chance of being approved
  )

  if property.save
    puts "Created property: #{property.title} in #{property.city}, #{property.country}"
  else
    puts "Failed to create property #{i}: #{property.errors.full_messages.join(', ')}"
  end
end

puts "Finished! Created #{Property.count} properties"
