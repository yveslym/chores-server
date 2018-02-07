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

ActiveRecord::Schema.define(version: 20180206204133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chores", force: :cascade do |t|
    t.string "name"
    t.string "due_date"
    t.string "penalty"
    t.string "reward"
    t.boolean "assigned"
    t.boolean "completed"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.index ["group_id"], name: "index_chores_on_group_id"
    t.index ["user_id"], name: "index_chores_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "chore_id"
    t.bigint "owner_id"
    t.index ["chore_id"], name: "index_groups_on_chore_id"
    t.index ["owner_id"], name: "index_groups_on_owner_id"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "reciever_id"
    t.bigint "group_id"
    t.bigint "sender_id"
    t.string "request_type"
    t.index ["group_id"], name: "index_requests_on_group_id"
    t.index ["reciever_id"], name: "index_requests_on_reciever_id"
    t.index ["sender_id"], name: "index_requests_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authentication_token", limit: 30
    t.bigint "group_id"
    t.bigint "chore_id"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["chore_id"], name: "index_users_on_chore_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "groups", "chores"
  add_foreign_key "groups", "users"
  add_foreign_key "groups", "users", column: "owner_id"
  add_foreign_key "users", "chores"
  add_foreign_key "users", "groups"
end
