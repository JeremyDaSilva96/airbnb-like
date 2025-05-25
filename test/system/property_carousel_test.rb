require "application_system_test_case"

class PropertyCarouselTest < ApplicationSystemTestCase
  setup do
    @property = properties(:one) # Assuming you have a property fixture
    # Attach test images to the property
    @property.photos.attach(
      io: File.open(Rails.root.join('test', 'fixtures', 'files', 'test_image1.jpg')),
      filename: 'test_image1.jpg',
      content_type: 'image/jpeg'
    )
    @property.photos.attach(
      io: File.open(Rails.root.join('test', 'fixtures', 'files', 'test_image2.jpg')),
      filename: 'test_image2.jpg',
      content_type: 'image/jpeg'
    )
  end

  test "can navigate through carousel images" do
    visit properties_path

    within "#carousel-#{@property.id}" do
      # Test next button
      assert_selector '.carousel-item.active', count: 1
      find('.carousel-control-next').click
      sleep 1 # Wait for transition
      assert_selector '.carousel-item.active', count: 1

      # Test previous button
      find('.carousel-control-prev').click
      sleep 1
      assert_selector '.carousel-item.active', count: 1

      # Test indicators
      all('.carousel-indicators button').last.click
      sleep 1
      assert_selector '.carousel-item.active', count: 1
    end
  end

  test "clicking carousel controls does not navigate to property page" do
    visit properties_path

    within "#carousel-#{@property.id}" do
      find('.carousel-control-next').click
      sleep 1
    end

    assert_current_path properties_path
  end
end
