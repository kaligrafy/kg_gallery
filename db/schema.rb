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
  enable_extension "uuid-ossp"

  create_table "kgg_attributes", force: :cascade do |t|
    t.string "shortname",   null: false
    t.string "name"
    t.text   "description"
    t.string "datatype",    null: false
    t.string "units"
    t.string "format"
  end

  add_index "kgg_attributes", ["datatype"], name: "idx_kgga_datatype", using: :btree
  add_index "kgg_attributes", ["description"], name: "idx_kgga_description", using: :btree
  add_index "kgg_attributes", ["format"], name: "idx_kgga_format", using: :btree
  add_index "kgg_attributes", ["name"], name: "idx_kgga_name", using: :btree
  add_index "kgg_attributes", ["shortname"], name: "idx_kgga_shortname", unique: true, using: :btree
  add_index "kgg_attributes", ["units"], name: "idx_kgga_units", using: :btree

  create_table "kgg_files", force: :cascade do |t|
    t.string   "shortname"
    t.string   "name"
    t.text     "description"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.string   "original_filename"
    t.string   "filetype"
    t.string   "version"
    t.text     "url"
    t.text     "note"
    t.jsonb    "exif",               default: {}, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kgg_files", ["description"], name: "idx_kggf_description", using: :btree
  add_index "kgg_files", ["exif"], name: "idx_kggf_exif", using: :gin
  add_index "kgg_files", ["filetype"], name: "idx_kggf_filetype", using: :btree
  add_index "kgg_files", ["media_content_type"], name: "idx_kggf_media_content_type", using: :btree
  add_index "kgg_files", ["media_file_name"], name: "idx_kggf_media_file_name", using: :btree
  add_index "kgg_files", ["media_file_size"], name: "idx_kggf_media_file_size", using: :btree
  add_index "kgg_files", ["media_updated_at"], name: "idx_kggf_media_updated_at", using: :btree
  add_index "kgg_files", ["name"], name: "idx_kggf_name", using: :btree
  add_index "kgg_files", ["original_filename"], name: "idx_kggf_original_filename", using: :btree
  add_index "kgg_files", ["shortname"], name: "idx_kggf_shortname", using: :btree
  add_index "kgg_files", ["url"], name: "idx_kggf_url", using: :btree
  add_index "kgg_files", ["version"], name: "idx_kggf_version", using: :btree

  create_table "kgg_groupings", force: :cascade do |t|
    t.string "shortname",                null: false
    t.string "name"
    t.text   "description"
    t.jsonb  "groupings",   default: {}, null: false
    t.jsonb  "attributes",  default: {}, null: false
  end

  add_index "kgg_groupings", ["attributes"], name: "idx_kggg_attributes", using: :gin
  add_index "kgg_groupings", ["description"], name: "idx_kggg_description", using: :btree
  add_index "kgg_groupings", ["groupings"], name: "idx_kggg_groupings", using: :gin
  add_index "kgg_groupings", ["name"], name: "idx_kggg_name", using: :btree
  add_index "kgg_groupings", ["shortname"], name: "idx_kggg_shortname", unique: true, using: :btree

  create_table "kgg_object_types", force: :cascade do |t|
    t.string   "shortname"
    t.string   "name"
    t.text     "description"
    t.integer  "grouping_ids",  array: true
    t.integer  "attribute_ids", array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kgg_object_types", ["attribute_ids"], name: "idx_kggot_attribute_ids", using: :gin
  add_index "kgg_object_types", ["description"], name: "idx_kggot_description", using: :btree
  add_index "kgg_object_types", ["grouping_ids"], name: "idx_kggot_grouping_ids", using: :gin
  add_index "kgg_object_types", ["name"], name: "idx_kggot_name", using: :btree
  add_index "kgg_object_types", ["shortname"], name: "idx_kggot_shortname", using: :btree

  create_table "kgg_objects", force: :cascade do |t|
    t.integer  "object_type_id",                    null: false
    t.string   "shortname"
    t.string   "name"
    t.text     "description"
    t.integer  "file_id"
    t.integer  "author_id"
    t.text     "note"
    t.jsonb    "groupings",            default: {}, null: false
    t.jsonb    "attributes",           default: {}, null: false
    t.integer  "secondary_file_ids",                             array: true
    t.integer  "secondary_author_ids",                           array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kgg_objects", ["attributes"], name: "idx_kggo_attributes", using: :gin
  add_index "kgg_objects", ["author_id"], name: "idx_kggo_author_id", using: :btree
  add_index "kgg_objects", ["description"], name: "idx_kggo_description", using: :btree
  add_index "kgg_objects", ["file_id"], name: "idx_kggo_file_id", using: :btree
  add_index "kgg_objects", ["groupings"], name: "idx_kggo_groupings", using: :gin
  add_index "kgg_objects", ["name"], name: "idx_kggo_name", using: :btree
  add_index "kgg_objects", ["secondary_author_ids"], name: "idx_kggo_secondary_author_ids", using: :gin
  add_index "kgg_objects", ["secondary_file_ids"], name: "idx_kggo_secondary_file_ids", using: :gin
  add_index "kgg_objects", ["shortname"], name: "idx_kggo_shortname", using: :btree

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

  add_foreign_key "kgg_objects", "kgg_files", column: "file_id", name: "fk_kggo_files"
  add_foreign_key "kgg_objects", "kgg_object_types", column: "object_type_id", name: "fk_kggo_object_types"
  add_foreign_key "kgg_objects", "users", column: "author_id", name: "fk_kggo_authors"
end
