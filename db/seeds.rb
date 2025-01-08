require 'open-uri'
require 'faker'

puts "Cleaning database..."
Property.destroy_all

puts "Creating properties..."

# Array of sample image URLs (beautiful properties from Unsplash)
sample_images = [
  'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
  'https://images.unsplash.com/photo-1493809842364-78817add7ffb',
  'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
  'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af',
  'https://images.unsplash.com/photo-1502005229762-cf1b2da7c5d6',
  'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
  'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9',
  'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
  'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
  'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3',
  'https://images.unsplash.com/photo-1600585154526-990dced4db0d',
  'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde'
]

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

  # Attach a random image from our sample images
  begin
    file = URI.open(sample_images[i]) # Use a different image for each property
    property.photos.attach(io: file, filename: "property_#{i}.jpg", content_type: "image/jpg")
    property.save!
    puts "Created property: #{property.title} in #{property.city}, #{property.country}"
  rescue => e
    puts "Failed to create property #{i}: #{e.message}"
  end
end

puts "Finished! Created #{Property.count} properties"
