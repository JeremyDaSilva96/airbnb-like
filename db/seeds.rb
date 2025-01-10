require 'faker'
require 'open-uri'
require 'unsplash'
require 'dotenv'
require 'cloudinary'

# Load environment variables
Dotenv.load

Unsplash.configure do |config|
  config.application_access_key = ENV['UNSPLASH_ACCESS_KEY']
  config.application_secret = ENV['UNSPLASH_SECRET_KEY']
  config.application_redirect_uri = "https://your-application-redirect-uri.com"
  config.utm_source = "airbnb_like_app"
end

Cloudinary.config do |config|
  config.cloud_name = ENV['CLOUDINARY_CLOUD_NAME']
  config.api_key = ENV['CLOUDINARY_API_KEY']
  config.api_secret = ENV['CLOUDINARY_API_SECRET']
end

puts "Cleaning database..."
Property.destroy_all

puts "Creating properties..."

# Property types with weighted options
property_types = [
  'Apartment', 'Apartment', 'House', 'House', 'Villa',
  'Loft', 'Studio', 'Penthouse', 'Cottage', 'Chalet'
]

# Search queries for different property types
property_queries = [
  ['modern apartment interior', 'apartment bedroom', 'apartment living room', 'apartment kitchen', 'apartment bathroom'],
  ['luxury house exterior', 'modern kitchen', 'master bedroom', 'house living room', 'house bathroom'],
  ['cozy living room', 'modern bathroom', 'dining room', 'bedroom design', 'house exterior'],
  ['modern villa', 'swimming pool', 'luxury interior', 'villa bedroom', 'villa garden'],
  ['penthouse view', 'luxury bedroom', 'modern kitchen', 'penthouse living', 'city skyline'],
  ['cottage exterior', 'cottage interior', 'cozy bedroom', 'cottage kitchen', 'cottage garden'],
  ['beach house', 'ocean view', 'modern interior', 'beach bedroom', 'beachfront'],
  ['mountain cabin', 'cabin interior', 'fireplace', 'cabin bedroom', 'mountain view'],
  ['modern loft', 'industrial kitchen', 'loft bedroom', 'loft living', 'loft bathroom'],
  ['luxury apartment', 'city view', 'modern living', 'designer kitchen', 'master suite'],
  ['studio apartment', 'compact kitchen', 'modern studio', 'studio living', 'small space design'],
  ['townhouse exterior', 'modern living room', 'contemporary kitchen', 'townhouse bedroom', 'urban home']
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
    approved: true,
    travelers_favorite: [true, false].sample
  )

  if property.save
    # Fetch and attach images from Unsplash
    property_queries[i].each_with_index do |query, index|
      begin
        # Search for multiple photos and get a random one
        photos = Unsplash::Photo.search(query)
        if photos.any?
          # Get a random photo from the first 5 results to add variety
          photo = photos.take(5).sample
          image_url = photo.urls.regular

          # Download the image
          downloaded_image = URI.open(image_url)
          
          # Upload to Cloudinary and attach to the property
          property.photos.attach(
            io: downloaded_image,
            filename: "property_#{property.id}_#{index + 1}_#{query.parameterize}.jpg",
            content_type: 'image/jpeg'
          )
          
          puts "  - Added photo #{index + 1}/5: #{query}"
        end
      rescue => e
        puts "Failed to attach image for property #{property.id} (#{query}): #{e.message}"
      end
      
      # Add a small delay to avoid hitting rate limits
      sleep(0.5)
    end
    puts "Created property: #{property.title} in #{property.city}, #{property.country}"
  end
end

puts "Finished! Created 12 properties"

# Re-enable geocoding callback
Property.set_callback(:validation, :after, :geocode)
