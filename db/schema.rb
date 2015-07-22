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

ActiveRecord::Schema.define(version: 20150722040025) do

  create_table "activities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "answers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "content",    limit: 255
    t.boolean  "correct"
    t.integer  "word_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "answers", ["word_id"], name: "index_answers_on_word_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "lesson_words", force: :cascade do |t|
    t.integer  "lesson_id",  limit: 4
    t.integer  "word_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "lesson_words", ["lesson_id"], name: "index_lesson_words_on_lesson_id", using: :btree
  add_index "lesson_words", ["word_id"], name: "index_lesson_words_on_word_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "user_id",     limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "lessons", ["category_id"], name: "index_lessons_on_category_id", using: :btree
  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.integer  "mark",       limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "answer_id",  limit: 4
    t.integer  "lesson_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "results", ["answer_id"], name: "index_results_on_answer_id", using: :btree
  add_index "results", ["lesson_id"], name: "index_results_on_lesson_id", using: :btree
  add_index "results", ["user_id"], name: "index_results_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "name",            limit: 255
    t.string   "avatar",          limit: 255
    t.string   "password_digest", limit: 255
    t.string   "remember_digest", limit: 255
    t.integer  "role",            limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "words", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "user_id",     limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "words", ["category_id"], name: "index_words_on_category_id", using: :btree
  add_index "words", ["user_id"], name: "index_words_on_user_id", using: :btree

  add_foreign_key "activities", "users"
  add_foreign_key "answers", "words"
  add_foreign_key "lesson_words", "lessons"
  add_foreign_key "lesson_words", "words"
  add_foreign_key "lessons", "categories"
  add_foreign_key "lessons", "users"
  add_foreign_key "results", "answers"
  add_foreign_key "results", "lessons"
  add_foreign_key "results", "users"
  add_foreign_key "words", "categories"
  add_foreign_key "words", "users"
end
