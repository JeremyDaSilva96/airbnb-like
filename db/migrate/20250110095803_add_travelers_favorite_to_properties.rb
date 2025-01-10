class AddTravelersFavoriteToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :travelers_favorite, :boolean, default: false, null: false
  end
end
