# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140214003513) do

  create_table "reservations", force: true do |t|
    t.integer  "party_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "restaurant_id"
    t.string   "name"
    t.date     "reservation_date"
    t.integer  "user_id"
    t.decimal  "reservation_hour"
  end

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.time     "opening_hour"
    t.time     "closing_hour"
    t.decimal  "seating_cycle"
    t.string   "picture"
    t.string   "description"
    t.string   "category1"
    t.string   "category2"
    t.string   "category3"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_type"
  end

end
