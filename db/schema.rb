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

ActiveRecord::Schema.define(version: 20140812231445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
  end

  add_index "accounts", ["subdomain"], name: "index_accounts_on_subdomain", unique: true, using: :btree

  create_table "activities", force: true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipient_id"
    t.string   "recipient_type"
  end

  add_index "activities", ["account_id"], name: "index_activities_on_account_id", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "appointments", force: true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.integer  "customer_profile_id"
    t.datetime "start"
    t.datetime "end"
    t.integer  "duration"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appointments", ["account_id"], name: "index_appointments_on_account_id", using: :btree

  create_table "assignments", force: true do |t|
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_hours", force: true do |t|
    t.integer  "account_id"
    t.string   "day"
    t.string   "open_time"
    t.string   "close_time"
    t.boolean  "is_closed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "business_hours", ["account_id"], name: "index_business_hours_on_account_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "account_id"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["account_id"], name: "index_comments_on_account_id", using: :btree
  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "customer_profiles", force: true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customer_profiles", ["account_id"], name: "index_customer_profiles_on_account_id", using: :btree
  add_index "customer_profiles", ["user_id"], name: "index_customer_profiles_on_user_id", using: :btree

  create_table "owners", force: true do |t|
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "owners", ["account_id"], name: "index_owners_on_account_id", using: :btree
  add_index "owners", ["user_id"], name: "index_owners_on_user_id", using: :btree

  create_table "registrations", force: true do |t|
    t.string   "company_name"
    t.string   "registrar_name"
    t.string   "registrar_email"
    t.string   "status"
    t.string   "token"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registrations", ["token"], name: "index_registrations_on_token", using: :btree

  create_table "schedulables", force: true do |t|
    t.integer  "service_id"
    t.integer  "appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "duration"
    t.decimal  "price",       precision: 8, scale: 2
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["account_id"], name: "index_services_on_account_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.string   "auth_token"
    t.string   "password_digest"
    t.string   "display_name"
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["auth_token"], name: "index_users_on_auth_token", using: :btree

end
