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

ActiveRecord::Schema.define(version: 20140813150050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "categories", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "creditcards", force: true do |t|
    t.integer  "user_id"
    t.string   "paypal_card_id"
    t.string   "name_on_card"
    t.string   "card_type"
    t.string   "issuer"
    t.integer  "last_4_digits"
    t.boolean  "active",         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.integer  "user_id"
    t.string   "brand"
    t.string   "model"
    t.string   "os"
    t.string   "app_version"
    t.string   "uid"
    t.string   "mobile_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip"
    t.string   "location"
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "events", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "category_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "date"
    t.boolean  "active",             default: true
    t.string   "address"
    t.string   "postcode"
    t.boolean  "featured",           default: false
    t.string   "city"
    t.integer  "created_by_id"
    t.datetime "end_date"
  end

  add_index "events", ["category_id"], name: "index_events_on_category_id", using: :btree
  add_index "events", ["date"], name: "index_events_on_date", using: :btree

  create_table "messages", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.uuid     "ticket_id"
    t.integer  "num_tickets",                         default: 1
    t.decimal  "price",       precision: 8, scale: 2
    t.boolean  "accepted",                            default: false
    t.boolean  "rejected",                            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.integer  "user_id"
    t.uuid     "event_id"
    t.decimal  "price",                 precision: 8, scale: 2
    t.string   "seat_type"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo1_file_name"
    t.string   "photo1_content_type"
    t.integer  "photo1_file_size"
    t.datetime "photo1_updated_at"
    t.string   "photo2_file_name"
    t.string   "photo2_content_type"
    t.integer  "photo2_file_size"
    t.datetime "photo2_updated_at"
    t.string   "photo3_file_name"
    t.string   "photo3_content_type"
    t.integer  "photo3_file_size"
    t.datetime "photo3_updated_at"
    t.string   "delivery_options"
    t.string   "payment_options"
    t.integer  "number_of_tickets",                             default: 1
    t.decimal  "face_value_per_ticket", precision: 8, scale: 2
    t.boolean  "available",                                     default: true
    t.string   "ticket_type"
  end

  add_index "tickets", ["event_id"], name: "index_tickets_on_event_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.string   "name"
    t.date     "date_of_birth"
    t.string   "city"
    t.string   "photo_url"
    t.string   "surname"
    t.boolean  "banned",                 default: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
