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

ActiveRecord::Schema.define(version: 20151126192446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "img_url"
  end

  create_table "images", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "remarks", force: :cascade do |t|
    t.text     "content"
    t.integer  "article_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "remarks", ["article_id"], name: "index_remarks_on_article_id", using: :btree
  add_index "remarks", ["user_id"], name: "index_remarks_on_user_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.string   "pet_name"
    t.string   "animal_type"
    t.float    "lat"
    t.float    "lng"
    t.integer  "user_id"
    t.string   "report_type"
    t.text     "notes"
    t.string   "img_url"
    t.string   "age"
    t.string   "breed"
    t.string   "sex"
    t.string   "pet_size"
    t.float    "distance"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "color"
    t.datetime "last_seen"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscriptions", ["report_id"], name: "index_subscriptions_on_report_id", using: :btree
  add_index "subscriptions", ["user_id", "report_id"], name: "index_subscriptions_on_user_id_and_report_id", unique: true, using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.integer  "zipcode"
    t.boolean  "logged_in",              default: true
    t.boolean  "admin",                  default: false
    t.integer  "wags",                   default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "authentication_token"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "image"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "articles", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "images", "users"
  add_foreign_key "remarks", "users"
  add_foreign_key "reports", "users"
  add_foreign_key "subscriptions", "reports"
  add_foreign_key "subscriptions", "users"
end
