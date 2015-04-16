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

ActiveRecord::Schema.define(version: 20150416090551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "anserws", force: :cascade do |t|
    t.string   "content",     null: false
    t.boolean  "correct"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
  end

  add_index "anserws", ["question_id"], name: "index_anserws_on_question_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "documents", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "attached_doc_file_name"
    t.string   "attached_doc_content_type"
    t.integer  "attached_doc_file_size"
    t.datetime "attached_doc_updated_at"
    t.integer  "lesson_id"
    t.string   "title"
  end

  add_index "documents", ["lesson_id"], name: "index_documents_on_lesson_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "course_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "content"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "test_id"
  end

  add_index "questions", ["test_id"], name: "index_questions_on_test_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.string   "sessionId"
    t.boolean  "public"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "rooms_users", id: false, force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.string   "description"
    t.integer  "lesson_id",   null: false
  end

  add_index "tests", ["lesson_id"], name: "index_tests_on_lesson_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "anserws", "questions"
  add_foreign_key "documents", "lessons"
  add_foreign_key "questions", "tests"
  add_foreign_key "tests", "lessons"
end
