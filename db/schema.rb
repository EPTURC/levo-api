# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_25_161004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drivers", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_drivers_on_user_id"
  end

  create_table "itineraries", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.bigint "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["driver_id"], name: "index_itineraries_on_driver_id"
    t.index ["vehicle_id"], name: "index_itineraries_on_vehicle_id"
  end

  create_table "itinerary_items", force: :cascade do |t|
    t.bigint "itinerary_id"
    t.integer "index"
    t.boolean "done"
    t.bigint "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["itinerary_id"], name: "index_itinerary_items_on_itinerary_id"
    t.index ["task_id"], name: "index_itinerary_items_on_task_id"
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_locations_on_vehicle_id"
  end

  create_table "occurrences", force: :cascade do |t|
    t.string "type"
    t.string "location"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "driver_id"
    t.bigint "itinerary_id"
    t.index ["driver_id"], name: "index_occurrences_on_driver_id"
    t.index ["itinerary_id"], name: "index_occurrences_on_itinerary_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "object"
    t.string "responsible_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "local"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_id"
  end

  add_foreign_key "drivers", "users"
  add_foreign_key "itineraries", "drivers"
  add_foreign_key "itineraries", "vehicles"
  add_foreign_key "itinerary_items", "itineraries"
  add_foreign_key "itinerary_items", "tasks"
  add_foreign_key "locations", "vehicles"
  add_foreign_key "occurrences", "drivers"
  add_foreign_key "occurrences", "itineraries"
end
