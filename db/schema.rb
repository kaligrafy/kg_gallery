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

ActiveRecord::Schema.define(version: 20130923212809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "hstore"

  create_table "kg_gallery_files", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "shortname"
    t.string   "original_filename"
    t.string   "filetype"
    t.string   "version"
    t.string   "name"
    t.text     "description"
    t.text     "url"
    t.text     "note"
    t.datetime "creation_date"
    t.hstore   "exif"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kg_gallery_files", ["creation_date"], name: "kggf_creation_date", using: :btree
  add_index "kg_gallery_files", ["description"], name: "kggf_description", using: :btree
  add_index "kg_gallery_files", ["filetype"], name: "kggf_filetype", using: :btree
  add_index "kg_gallery_files", ["name"], name: "kggf_name", using: :btree
  add_index "kg_gallery_files", ["original_filename"], name: "kggf_original_filename", using: :btree
  add_index "kg_gallery_files", ["shortname"], name: "kggf_shortname", using: :btree
  add_index "kg_gallery_files", ["url"], name: "kggf_url", using: :btree
  add_index "kg_gallery_files", ["version"], name: "kggf_version", using: :btree

  create_table "kg_gallery_objects", force: :cascade do |t|
    t.integer  "object_type_id",              null: false
    t.string   "shortname"
    t.string   "name"
    t.text     "description"
    t.integer  "file_id"
    t.integer  "author_id"
    t.text     "note"
    t.jsonb    "groupings",      default: {}, null: false
    t.jsonb    "attributes",     default: {}, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kg_gallery_objects", ["attributes"], name: "index_kg_gallery_objects_on_attributes", using: :gin
  add_index "kg_gallery_objects", ["description"], name: "index_kg_gallery_objects_on_description", using: :btree
  add_index "kg_gallery_objects", ["groupings"], name: "index_kg_gallery_objects_on_groupings", using: :gin
  add_index "kg_gallery_objects", ["name"], name: "index_kg_gallery_objects_on_name", using: :btree
  add_index "kg_gallery_objects", ["shortname"], name: "index_kg_gallery_objects_on_shortname", using: :btree

  create_table "kgg_attributes", force: :cascade do |t|
    t.string "shortname",   null: false
    t.string "datatype",    null: false
    t.string "name"
    t.text   "description"
  end

  add_index "kgg_attributes", ["datatype"], name: "index_kgg_attributes_on_datatype", using: :btree
  add_index "kgg_attributes", ["name"], name: "index_kgg_attributes_on_name", using: :btree
  add_index "kgg_attributes", ["shortname"], name: "index_kgg_attributes_on_shortname", unique: true, using: :btree

  create_table "kgg_groupings", force: :cascade do |t|
    t.string "shortname",                null: false
    t.string "name"
    t.text   "description"
    t.jsonb  "groupings",   default: {}, null: false
    t.jsonb  "attributes",  default: {}, null: false
  end

  add_index "kgg_groupings", ["attributes"], name: "index_kgg_groupings_on_attributes", using: :gin
  add_index "kgg_groupings", ["groupings"], name: "index_kgg_groupings_on_groupings", using: :gin
  add_index "kgg_groupings", ["name"], name: "index_kgg_groupings_on_name", using: :btree
  add_index "kgg_groupings", ["shortname"], name: "index_kgg_groupings_on_shortname", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "username"
    t.string   "phone"
    t.boolean  "admin",                  default: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "initial"
    t.date     "birthdate"
    t.boolean  "is_enabled"
    t.boolean  "is_valid"
    t.boolean  "is_test"
    t.jsonb    "groupings",              default: {},    null: false
    t.jsonb    "attributes",             default: {},    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["attributes"], name: "index_users_on_attributes", using: :gin
  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["birthdate"], name: "index_users_on_birthdate", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["current_sign_in_ip"], name: "index_users_on_current_sign_in_ip", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["encrypted_password"], name: "index_users_on_encrypted_password", using: :btree
  add_index "users", ["failed_attempts"], name: "index_users_on_failed_attempts", using: :btree
  add_index "users", ["firstname"], name: "index_users_on_firstname", using: :btree
  add_index "users", ["groupings"], name: "index_users_on_groupings", using: :gin
  add_index "users", ["initial"], name: "index_users_on_initial", using: :btree
  add_index "users", ["is_enabled"], name: "index_users_on_is_enabled", using: :btree
  add_index "users", ["is_test"], name: "index_users_on_is_test", using: :btree
  add_index "users", ["is_valid"], name: "index_users_on_is_valid", using: :btree
  add_index "users", ["last_sign_in_ip"], name: "index_users_on_last_sign_in_ip", using: :btree
  add_index "users", ["lastname"], name: "index_users_on_lastname", using: :btree
  add_index "users", ["phone"], name: "index_users_on_phone", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["sign_in_count"], name: "index_users_on_sign_in_count", using: :btree
  add_index "users", ["unconfirmed_email"], name: "index_users_on_unconfirmed_email", using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
