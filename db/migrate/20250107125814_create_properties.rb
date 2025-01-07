class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :title
      t.text :description
      t.string :property_type
      t.decimal :price_per_night
      t.decimal :cleaning_fee
      t.decimal :service_fee
      t.integer :max_guests
      t.integer :bedrooms
      t.integer :beds
      t.integer :bathrooms
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code
      t.float :latitude
      t.float :longitude
      t.boolean :active
      t.boolean :approved

      t.timestamps
    end
  end
end
