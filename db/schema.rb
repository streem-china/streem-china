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

ActiveRecord::Schema.define(version: 20150305064948) do

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authorizations", ["provider", "uid"], name: "index_authorizations_on_provider_and_uid", unique: true

  create_table "favorites", force: :cascade do |t|
    t.string   "favoritable_type", null: false
    t.integer  "favoritable_id",   null: false
    t.integer  "user_id",          null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "favorites", ["user_id", "favoritable_id", "favoritable_type"], name: "user_favoritable", unique: true

  create_table "mentions", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.integer  "mentionable_id",   null: false
    t.string   "mentionable_type", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "mentions", ["user_id", "mentionable_id", "mentionable_type"], name: "user_mentionable", unique: true

  create_table "nodes", force: :cascade do |t|
    t.string  "name"
    t.integer "topics_count", default: 0
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.integer  "reply_id"
    t.integer  "mention_id"
    t.string   "type",                        null: false
    t.boolean  "read",        default: false
    t.integer  "favorite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "replies", force: :cascade do |t|
    t.integer  "topic_id",                    null: false
    t.integer  "user_id",                     null: false
    t.text     "body"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "deleted_at"
    t.text     "body_html"
    t.integer  "floor"
    t.string   "user_name"
    t.string   "user_avatar"
    t.integer  "favorites_count", default: 0
  end

  add_index "replies", ["deleted_at"], name: "index_replies_on_deleted_at"
  add_index "replies", ["topic_id", "floor"], name: "index_replies_on_topic_id_and_floor", unique: true
  add_index "replies", ["topic_id"], name: "index_replies_on_topic_id"

  create_table "topics", force: :cascade do |t|
    t.integer  "user_id",                            null: false
    t.string   "title",                              null: false
    t.text     "body",                               null: false
    t.integer  "replies_count",          default: 0, null: false
    t.integer  "last_replied_user_id"
    t.datetime "last_replied_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.datetime "deleted_at"
    t.text     "body_html"
    t.integer  "last_reply_id"
    t.string   "last_replied_user_name"
    t.datetime "actived_at"
    t.string   "user_name"
    t.string   "user_avatar"
    t.integer  "favorites_count",        default: 0
    t.integer  "node_id",                default: 1
  end

  add_index "topics", ["actived_at"], name: "index_topics_on_actived_at"
  add_index "topics", ["deleted_at"], name: "index_topics_on_deleted_at"
  add_index "topics", ["last_replied_at"], name: "index_topics_on_last_replied_at"

  create_table "users", force: :cascade do |t|
    t.string   "name",                                    null: false
    t.string   "avatar"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "email",                      default: "", null: false
    t.integer  "topics_count",               default: 0
    t.integer  "replies_count",              default: 0
    t.integer  "favorites_count",            default: 0
    t.integer  "notifications_count",        default: 0
    t.integer  "unread_notifications_count", default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true

end
