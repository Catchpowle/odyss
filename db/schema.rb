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

ActiveRecord::Schema.define(version: 20161203124425) do

  create_table "groups", force: :cascade do |t|
    t.text     "name",        null: false
    t.text     "objective",   null: false
    t.text     "information", null: false
    t.integer  "limit",       null: false
    t.date     "start_date",  null: false
    t.text     "discord_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "identities", force: :cascade do |t|
    t.text     "uid",        null: false
    t.text     "provider",   null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id"
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id"

  create_table "notifications", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "notifications", ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id"
  add_index "notifications", ["sender_id"], name: "index_notifications_on_sender_id"

  create_table "notifications_users", force: :cascade do |t|
    t.integer  "notification_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "notifications_users", ["notification_id"], name: "index_notifications_users_on_notification_id"
  add_index "notifications_users", ["user_id"], name: "index_notifications_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.text     "name",       null: false
    t.text     "email",      null: false
    t.text     "image_url"
    t.text     "discord_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
