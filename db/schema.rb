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

ActiveRecord::Schema.define(version: 20150709051027) do

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
    t.string   "name"
    t.integer  "topics_count", default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.integer  "reply_id"
    t.integer  "mention_id"
    t.integer  "favorite_id"
    t.string   "type",                        null: false
    t.boolean  "read",        default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "notifications", ["favorite_id"], name: "index_notifications_on_favorite_id"
  add_index "notifications", ["mention_id"], name: "index_notifications_on_mention_id"
  add_index "notifications", ["reply_id"], name: "index_notifications_on_reply_id"
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "location"
    t.string   "company"
    t.string   "blog_link"
    t.string   "github_link"
    t.string   "twitter_link"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "replies", force: :cascade do |t|
    t.integer  "topic_id",                    null: false
    t.integer  "user_id",                     null: false
    t.integer  "floor",           default: 1, null: false
    t.integer  "favorites_count", default: 0, null: false
    t.string   "user_name",                   null: false
    t.string   "user_avatar",                 null: false
    t.text     "body",                        null: false
    t.text     "body_html",                   null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "replies", ["topic_id", "floor"], name: "index_replies_on_topic_id_and_floor", unique: true
  add_index "replies", ["topic_id"], name: "index_replies_on_topic_id"

  create_table "tips", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "user_id",                                null: false
    t.integer  "node_id",                                null: false
    t.integer  "replies_count",          default: 0,     null: false
    t.integer  "favorites_count",        default: 0,     null: false
    t.integer  "last_replied_user_id"
    t.string   "node_name",                              null: false
    t.string   "title",                                  null: false
    t.string   "last_replied_user_name"
    t.string   "user_name",                              null: false
    t.string   "user_avatar",                            null: false
    t.datetime "actived_at",                             null: false
    t.datetime "last_replied_at"
    t.text     "body",                                   null: false
    t.text     "body_html",                              null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "stick",                  default: false
  end

  add_index "topics", ["user_id"], name: "index_topics_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name",                                   null: false
    t.string   "avatar"
    t.integer  "topics_count",               default: 0, null: false
    t.integer  "replies_count",              default: 0, null: false
    t.integer  "favorites_count",            default: 0, null: false
    t.integer  "notifications_count",        default: 0, null: false
    t.integer  "unread_notifications_count", default: 0, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",            default: 0, null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
