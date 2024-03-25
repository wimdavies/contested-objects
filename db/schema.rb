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

ActiveRecord::Schema[7.1].define(version: 2024_03_25_163109) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "museum_objects", force: :cascade do |t|
    t.string "system_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["system_number"], name: "index_museum_objects_on_system_number", unique: true
  end

  create_table "reflections", force: :cascade do |t|
    t.boolean "deaccession_flag"
    t.text "deaccession_reason"
    t.text "provenance_thoughts"
    t.text "presence_feelings"
    t.text "absence_feelings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "museum_object_id", null: false
    t.index ["museum_object_id"], name: "index_reflections_on_museum_object_id"
    t.index ["user_id"], name: "index_reflections_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "reflections", "museum_objects"
  add_foreign_key "reflections", "users"
end
