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

ActiveRecord::Schema.define(version: 20150202024722) do

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authorizations", ["provider", "uid"], name: "index_authorizations_on_provider_and_uid", unique: true

  create_table "replies", force: :cascade do |t|
    t.integer  "topic_id",   null: false
    t.integer  "user_id",    null: false
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.text     "body_html"
    t.integer  "floor"
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
  end

  add_index "topics", ["deleted_at"], name: "index_topics_on_deleted_at"
  add_index "topics", ["last_replied_at"], name: "index_topics_on_last_replied_at"

  create_table "users", force: :cascade do |t|
    t.string   "name",                    null: false
    t.string   "avatar"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "email",      default: "", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
