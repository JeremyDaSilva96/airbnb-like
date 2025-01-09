require 'faker'
require 'open-uri'

puts "Cleaning database..."
Property.destroy_all

puts "Creating properties..."

# Property types with weighted options
property_types = [
  'Apartment', 'Apartment', 'House', 'House', 'Villa',
  'Loft', 'Studio', 'Penthouse', 'Cottage', 'Chalet'
]

# Temporarily skip geocoding callback
Property.skip_callback(:validation, :after, :geocode)

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
    approved: true  # Always approved
  )

  if property.save
    # Attach sample images from Unsplash
    3.times do
      begin
        file = URI.open("https://source.unsplash.com/random/1200x800/?#{property.property_type.downcase},interior")
        property.photos.attach(io: file, filename: "property_#{property.id}_#{rand(1000)}.jpg", content_type: 'image/jpeg')
      rescue => e
        puts "Failed to attach image for property #{property.id}: #{e.message}"
      end
    end
    puts "Created property: #{property.title} in #{property.city}, #{property.country}"
  else
    puts "Failed to create property #{i}: #{property.errors.full_messages.join(', ')}"
  end
end

# Re-enable geocoding callback
Property.set_callback(:validation, :after, :geocode)

puts "Finished! Created #{Property.count} properties"
