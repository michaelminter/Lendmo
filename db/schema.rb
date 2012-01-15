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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120115051555) do

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.string   "image_uri"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "badge_id"
  end

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "user_id"
  end

  create_table "events", :force => true do |t|
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "islending"
    t.integer  "lender_id"
    t.integer  "borrower_id"
    t.string   "item_name"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "user_id"
    t.integer  "borrower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "value"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "fb_id"
    t.integer  "num_lends"
  end

end
