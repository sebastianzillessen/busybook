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

ActiveRecord::Schema.define(version: 20161106153409) do

  create_table "calendars", force: :cascade do |t|
    t.text     "props_json"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uri"
    t.index ["uri", "user_id"], name: "index_calendars_on_uri_and_user_id", unique: true
    t.index ["user_id"], name: "index_calendars_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "approved",    default: false
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string   "component"
    t.text     "summary"
    t.datetime "date_start"
    t.datetime "date_end"
    t.string   "uri"
    t.text     "ics"
    t.integer  "calendar_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "offer_id"
    t.boolean  "approved",    default: false
    t.boolean  "rejected",    default: false
    t.index ["calendar_id"], name: "index_schedules_on_calendar_id"
    t.index ["offer_id"], name: "index_schedules_on_offer_id"
    t.index ["updated_at"], name: "index_schedules_on_updated_at"
    t.index ["uri"], name: "index_schedules_on_uri", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "password_hash"
    t.string   "password_salt"
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
