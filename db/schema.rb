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

ActiveRecord::Schema.define(version: 20151207010621) do

  create_table "channel_admins", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "channel_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "channel_admins", ["channel_id"], name: "index_channel_admins_on_channel_id", using: :btree
  add_index "channel_admins", ["user_id"], name: "index_channel_admins_on_user_id", using: :btree

  create_table "channels", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "image",       limit: 255
    t.string   "post_type",   limit: 255
    t.string   "rss_link",    limit: 255
    t.boolean  "approved"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "slug",        limit: 255
    t.string   "api_key",     limit: 255
    t.text     "description", limit: 65535
  end

  add_index "channels", ["api_key"], name: "index_channels_on_api_key", unique: true, using: :btree
  add_index "channels", ["slug"], name: "index_channels_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "link",        limit: 255
    t.integer  "user_id",     limit: 4
    t.integer  "channel_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "description", limit: 65535
  end

  add_index "posts", ["channel_id"], name: "index_posts_on_channel_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "channel_id", limit: 4
    t.boolean  "approved"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "subscriptions", ["channel_id"], name: "index_subscriptions_on_channel_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "role",       limit: 4
    t.string   "email",      limit: 255
    t.string   "avatar",     limit: 255
    t.string   "gcm_token",  limit: 255
    t.string   "api_key",    limit: 255
    t.boolean  "admin"
    t.boolean  "superadmin"
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id",       limit: 4
    t.string  "foreign_key_name", limit: 255, null: false
    t.integer "foreign_key_id",   limit: 4
  end

  add_index "version_associations", ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key", using: :btree
  add_index "version_associations", ["version_id"], name: "index_version_associations_on_version_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 255,        null: false
    t.integer  "item_id",        limit: 4,          null: false
    t.string   "event",          limit: 255,        null: false
    t.string   "whodunnit",      limit: 255
    t.text     "object",         limit: 4294967295
    t.datetime "created_at"
    t.text     "object_changes", limit: 4294967295
    t.integer  "transaction_id", limit: 4
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  add_index "versions", ["transaction_id"], name: "index_versions_on_transaction_id", using: :btree

  add_foreign_key "channel_admins", "channels"
  add_foreign_key "channel_admins", "users"
  add_foreign_key "posts", "channels"
  add_foreign_key "posts", "users"
  add_foreign_key "subscriptions", "channels"
  add_foreign_key "subscriptions", "users"
end
