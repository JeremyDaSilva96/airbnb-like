# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_01_08_122548) do
  create_table "bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "property_id", null: false
    t.date "check_in"
    t.date "check_out"
    t.integer "number_of_guests"
    t.decimal "total_price", precision: 10, scale: 2
    t.string "status"
    t.text "special_requests"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_bookings_on_property_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "property_type"
    t.decimal "price_per_night"
    t.decimal "cleaning_fee"
    t.decimal "service_fee"
    t.integer "max_guests"
    t.integer "bedrooms"
    t.integer "beds"
    t.integer "bathrooms"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip_code"
    t.float "latitude"
    t.float "longitude"
    t.boolean "active"
    t.boolean "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookings", "properties"
  add_foreign_key "bookings", "users"
end
