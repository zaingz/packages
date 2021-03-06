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

ActiveRecord::Schema.define(version: 20140714121946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "packages", force: true do |t|
    t.string   "tittle",             default: "Package Tittle",      null: false
    t.text     "description",        default: "Package description", null: false
    t.float    "src_lat",                                            null: false
    t.float    "src_lon",                                            null: false
    t.float    "dest_lat",                                           null: false
    t.float    "dest_lon",                                           null: false
    t.boolean  "delivered",          default: false,                 null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "src_address"
  end

  create_table "requests", force: true do |t|
    t.integer  "user_id"
    t.text     "message",    default: "",    null: false
    t.boolean  "accepted",   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "package_id"
  end

  add_index "requests", ["user_id"], name: "index_requests_on_user_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "username",                          default: "", null: false
    t.string   "mobile_number",          limit: 15,              null: false
    t.string   "home_address",                      default: "", null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
