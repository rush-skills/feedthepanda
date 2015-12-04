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

ActiveRecord::Schema.define(version: 20151204011306) do

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
    t.string   "description", limit: 255
    t.string   "image",       limit: 255
    t.string   "post_type",   limit: 255
    t.string   "rss_link",    limit: 255
    t.boolean  "approved"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.string   "link",        limit: 255
    t.integer  "user_id",     limit: 4
    t.integer  "channel_id",  limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
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

  add_foreign_key "channel_admins", "channels"
  add_foreign_key "channel_admins", "users"
  add_foreign_key "posts", "channels"
  add_foreign_key "posts", "users"
  add_foreign_key "subscriptions", "channels"
  add_foreign_key "subscriptions", "users"
end
