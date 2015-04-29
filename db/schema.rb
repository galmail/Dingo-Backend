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

ActiveRecord::Schema.define(version: 20150429113700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "alerts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "user_id"
    t.uuid     "event_id"
    t.decimal  "price",                   precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description", limit: 255
    t.boolean  "active",                                          default: true
  end

  create_table "categories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "creditcards", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "paypal_card_id", limit: 255
    t.string   "name_on_card",   limit: 255
    t.string   "card_type",      limit: 255
    t.string   "issuer",         limit: 255
    t.integer  "last_4_digits"
    t.boolean  "active",                     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "brand",         limit: 255
    t.string   "model",         limit: 255
    t.string   "os",            limit: 255
    t.string   "app_version",   limit: 255
    t.string   "uid",           limit: 255
    t.string   "mobile_number", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip",            limit: 255
    t.string   "location",      limit: 255
    t.boolean  "banned",                    default: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "events", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "description",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "category_id"
    t.string   "photo_file_name",           limit: 255
    t.string   "photo_content_type",        limit: 255
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "date"
    t.boolean  "active",                                                        default: true
    t.string   "address",                   limit: 255
    t.string   "postcode",                  limit: 255
    t.boolean  "featured",                                                      default: false
    t.string   "city",                      limit: 255
    t.integer  "created_by_id"
    t.datetime "end_date"
    t.boolean  "test",                                                          default: false
    t.boolean  "for_sale",                                                      default: false
    t.decimal  "min_price",                             precision: 8, scale: 2, default: 0.0
    t.integer  "available_tickets",                                             default: 0
    t.uuid     "venue_id"
    t.string   "primary_ticket_seller_url", limit: 255
    t.string   "info_url"
  end

  add_index "events", ["category_id"], name: "index_events_on_category_id", using: :btree
  add_index "events", ["date"], name: "index_events_on_date", using: :btree
  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

  create_table "messages", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "content",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "from_dingo",                  default: false
    t.boolean  "new_offer",                   default: false
    t.boolean  "visible",                     default: true
    t.uuid     "ticket_id"
    t.uuid     "offer_id"
    t.boolean  "read",                        default: false
    t.string   "conversation_id", limit: 255
  end

  add_index "messages", ["offer_id"], name: "index_messages_on_offer_id", using: :btree
  add_index "messages", ["ticket_id"], name: "index_messages_on_ticket_id", using: :btree

  create_table "offers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
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

  create_table "orders", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.uuid     "ticket_id"
    t.uuid     "creditcard_id"
    t.uuid     "event_id"
    t.uuid     "offer_id"
    t.integer  "num_tickets",                                                  default: 1
    t.decimal  "amount",                               precision: 8, scale: 2
    t.string   "status",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paypal_key",               limit: 255
    t.text     "buyers_note"
    t.string   "delivery_options",         limit: 255
    t.uuid     "promo_id"
    t.boolean  "pending_payment_notified",                                     default: false
  end

  create_table "promos", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "description",     limit: 255
    t.datetime "expiry_date"
    t.boolean  "active",                      default: true
    t.boolean  "commission_free",             default: false
    t.integer  "discount",                    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code",            limit: 255
  end

  create_table "tickets", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "user_id"
    t.uuid     "event_id"
    t.decimal  "price",                              precision: 8, scale: 2
    t.string   "seat_type",              limit: 255
    t.string   "description",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo1_file_name",       limit: 255
    t.string   "photo1_content_type",    limit: 255
    t.integer  "photo1_file_size"
    t.datetime "photo1_updated_at"
    t.string   "photo2_file_name",       limit: 255
    t.string   "photo2_content_type",    limit: 255
    t.integer  "photo2_file_size"
    t.datetime "photo2_updated_at"
    t.string   "photo3_file_name",       limit: 255
    t.string   "photo3_content_type",    limit: 255
    t.integer  "photo3_file_size"
    t.datetime "photo3_updated_at"
    t.string   "delivery_options",       limit: 255
    t.string   "payment_options",        limit: 255
    t.integer  "number_of_tickets",                                          default: 1
    t.decimal  "face_value_per_ticket",              precision: 8, scale: 2
    t.boolean  "available",                                                  default: true
    t.string   "ticket_type",            limit: 255
    t.integer  "number_of_tickets_sold",                                     default: 0
  end

  add_index "tickets", ["event_id"], name: "index_tickets_on_event_id", using: :btree

  create_table "user_blockings", id: false, force: :cascade do |t|
    t.integer "blocking_user_id", null: false
    t.integer "blocked_user_id",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                    limit: 255, default: "",    null: false
    t.string   "encrypted_password",       limit: 255, default: "",    null: false
    t.string   "reset_password_token",     limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",       limit: 255
    t.string   "last_sign_in_ip",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token",     limit: 255
    t.string   "name",                     limit: 255
    t.date     "date_of_birth"
    t.string   "city",                     limit: 255
    t.string   "photo_url",                limit: 255
    t.string   "surname",                  limit: 255
    t.boolean  "banned",                               default: false
    t.boolean  "allow_dingo_emails",                   default: true
    t.boolean  "allow_push_notifications",             default: true
    t.string   "fb_id",                    limit: 255
    t.string   "paypal_account",           limit: 255
    t.string   "promo",                    limit: 255
    t.boolean  "promo_used",                           default: false
    t.string   "notification_email",       limit: 255
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "city",           limit: 255
    t.string   "address",        limit: 255
    t.string   "layout_map_url", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
