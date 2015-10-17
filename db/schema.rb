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
  enable_extension "hstore"
  enable_extension "postgis"

  create_table "kg_gallery_attribute_choices", force: :cascade do |t|
    t.string  "attribute_sn",                                                       null: false
    t.string  "shortname",                                                          null: false
    t.boolean "is_group",                                           default: false
    t.string  "group_sn"
    t.integer "sequence"
    t.string  "internal_id"
    t.string  "name"
    t.text    "description"
    t.float   "range_float_start_value"
    t.float   "range_float_end_value"
    t.integer "range_integer_start_value"
    t.integer "range_integer_end_value"
    t.decimal "range_money_start_value",   precision: 30, scale: 2
    t.decimal "range_money_end_value",     precision: 30, scale: 2
    t.text    "note"
  end

  add_index "kg_gallery_attribute_choices", ["attribute_sn"], name: "kggac_attribute_id", using: :btree
  add_index "kg_gallery_attribute_choices", ["description"], name: "kggac_description", using: :btree
  add_index "kg_gallery_attribute_choices", ["group_sn"], name: "kggac_group_id", using: :btree
  add_index "kg_gallery_attribute_choices", ["internal_id"], name: "kggac_internal_id", using: :btree
  add_index "kg_gallery_attribute_choices", ["is_group"], name: "kggac_is_group", using: :btree
  add_index "kg_gallery_attribute_choices", ["name"], name: "kggac_name", using: :btree
  add_index "kg_gallery_attribute_choices", ["range_float_end_value"], name: "kggac_range_float_end_value", using: :btree
  add_index "kg_gallery_attribute_choices", ["range_float_start_value"], name: "kggac_range_float_start_value", using: :btree
  add_index "kg_gallery_attribute_choices", ["range_integer_end_value"], name: "kggac_range_integer_end_value", using: :btree
  add_index "kg_gallery_attribute_choices", ["range_integer_start_value"], name: "kggac_range_integer_start_value", using: :btree
  add_index "kg_gallery_attribute_choices", ["range_money_end_value"], name: "kggac_range_money_end_value", using: :btree
  add_index "kg_gallery_attribute_choices", ["range_money_start_value"], name: "kggac_range_money_start_value", using: :btree
  add_index "kg_gallery_attribute_choices", ["sequence"], name: "kggac_sequence", using: :btree
  add_index "kg_gallery_attribute_choices", ["shortname"], name: "kggac_shortname", using: :btree

  create_table "kg_gallery_attribute_values", force: :cascade do |t|
    t.string    "object_table_name",                                                                                            null: false
    t.string    "object_class_name",                                                                                            null: false
    t.integer   "object__id",                                                                                                   null: false
    t.string    "attribute_sn",                                                                                                 null: false
    t.string    "choice_sn"
    t.string    "multiple_choices_sns",                                                                                                      array: true
    t.string    "value_object_table_name"
    t.string    "value_object_class_name"
    t.integer   "value_object__id"
    t.integer   "value_integer"
    t.float     "value_float"
    t.boolean   "value_boolean"
    t.string    "value_string"
    t.text      "value_text"
    t.datetime  "value_datetime"
    t.date      "value_date"
    t.time      "value_time"
    t.decimal   "value_money",                                                                         precision: 30, scale: 2
    t.integer   "value_array_integer",                                                                                                       array: true
    t.string    "value_array_string",                                                                                                        array: true
    t.text      "value_array_text",                                                                                                          array: true
    t.integer   "value_array_object__ids",                                                                                                   array: true
    t.hstore    "value_hash"
    t.text      "value_json"
    t.geography "value_geography",         limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.text      "note"
  end

  add_index "kg_gallery_attribute_values", ["attribute_sn"], name: "kggav_attribute_sn", using: :btree
  add_index "kg_gallery_attribute_values", ["choice_sn"], name: "kggav_choice_sn", using: :btree
  add_index "kg_gallery_attribute_values", ["multiple_choices_sns"], name: "kggav_multiple_choices_sns", using: :gin
  add_index "kg_gallery_attribute_values", ["object__id"], name: "kggav_object__id", using: :btree
  add_index "kg_gallery_attribute_values", ["object_class_name"], name: "kggav_object_class_name", using: :btree
  add_index "kg_gallery_attribute_values", ["object_table_name"], name: "kggav_object_table_name", using: :btree
  add_index "kg_gallery_attribute_values", ["value_array_integer"], name: "kggav_value_array_integer", using: :gin
  add_index "kg_gallery_attribute_values", ["value_array_object__ids"], name: "kggav_value_array_object__ids", using: :gin
  add_index "kg_gallery_attribute_values", ["value_array_string"], name: "kggav_value_array_string", using: :gin
  add_index "kg_gallery_attribute_values", ["value_array_text"], name: "kggav_value_array_text", using: :gin
  add_index "kg_gallery_attribute_values", ["value_boolean"], name: "kggav_value_boolean", using: :btree
  add_index "kg_gallery_attribute_values", ["value_date"], name: "kggav_value_date", using: :btree
  add_index "kg_gallery_attribute_values", ["value_datetime"], name: "kggav_value_datetime", using: :btree
  add_index "kg_gallery_attribute_values", ["value_float"], name: "kggav_value_float", using: :btree
  add_index "kg_gallery_attribute_values", ["value_geography"], name: "kggav_value_geography", using: :gist
  add_index "kg_gallery_attribute_values", ["value_hash"], name: "kggav_value_hash", using: :gin
  add_index "kg_gallery_attribute_values", ["value_integer"], name: "kggav_value_integer", using: :btree
  add_index "kg_gallery_attribute_values", ["value_json"], name: "kggav_value_json", using: :btree
  add_index "kg_gallery_attribute_values", ["value_money"], name: "kggav_value_money", using: :btree
  add_index "kg_gallery_attribute_values", ["value_object__id"], name: "kggav_value_object__id", using: :btree
  add_index "kg_gallery_attribute_values", ["value_object_class_name"], name: "kggav_value_object_class_name", using: :btree
  add_index "kg_gallery_attribute_values", ["value_object_table_name"], name: "kggav_value_object_table_name", using: :btree
  add_index "kg_gallery_attribute_values", ["value_string"], name: "kggav_value_string", using: :btree
  add_index "kg_gallery_attribute_values", ["value_text"], name: "kggav_value_text", using: :btree
  add_index "kg_gallery_attribute_values", ["value_time"], name: "kggav_value_time", using: :btree

  create_table "kg_gallery_attributes", force: :cascade do |t|
    t.string  "shortname",                            null: false
    t.string  "datatype",                             null: false
    t.boolean "has_choices",          default: false
    t.boolean "has_multiple_choices", default: false
    t.string  "internal_id"
    t.string  "name"
    t.text    "description"
    t.text    "note"
  end

  add_index "kg_gallery_attributes", ["datatype"], name: "kgga_datatype", using: :btree
  add_index "kg_gallery_attributes", ["description"], name: "kgga_description", using: :btree
  add_index "kg_gallery_attributes", ["has_choices"], name: "kgga_has_choices", using: :btree
  add_index "kg_gallery_attributes", ["has_multiple_choices"], name: "kgga_has_multiple_choices", using: :btree
  add_index "kg_gallery_attributes", ["internal_id"], name: "kgga_internal_id", using: :btree
  add_index "kg_gallery_attributes", ["name"], name: "kgga_name", using: :btree
  add_index "kg_gallery_attributes", ["shortname"], name: "kgga_shortname", unique: true, using: :btree

  create_table "kg_gallery_files", force: :cascade do |t|
    t.string   "shortname"
    t.string   "filename_file_name"
    t.string   "filename_content_type"
    t.integer  "filename_file_size"
    t.datetime "filename_updated_at"
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
    t.string   "object_type_shortname", null: false
    t.string   "shortname"
    t.string   "name"
    t.text     "description"
    t.integer  "file_id"
    t.integer  "author_id"
    t.integer  "file_ids",                           array: true
    t.integer  "author_ids",                         array: true
    t.integer  "parent_ids",                         array: true
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kg_gallery_objects", ["author_id"], name: "kggo_author_id", using: :btree
  add_index "kg_gallery_objects", ["author_ids"], name: "kggo_author_ids", using: :gin
  add_index "kg_gallery_objects", ["description"], name: "kggo_description", using: :btree
  add_index "kg_gallery_objects", ["file_id"], name: "kggo_file_id", using: :btree
  add_index "kg_gallery_objects", ["file_ids"], name: "kggo_file_ids", using: :gin
  add_index "kg_gallery_objects", ["name"], name: "kggo_name", using: :btree
  add_index "kg_gallery_objects", ["object_type_shortname"], name: "kggo_object_type_shortname", using: :btree
  add_index "kg_gallery_objects", ["parent_ids"], name: "kggo_parent_ids", using: :gin
  add_index "kg_gallery_objects", ["shortname"], name: "kggo_shortname", using: :btree

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["birthdate"], name: "index_users_on_birthdate", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["current_sign_in_ip"], name: "index_users_on_current_sign_in_ip", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["encrypted_password"], name: "index_users_on_encrypted_password", using: :btree
  add_index "users", ["failed_attempts"], name: "index_users_on_failed_attempts", using: :btree
  add_index "users", ["firstname"], name: "index_users_on_firstname", using: :btree
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
