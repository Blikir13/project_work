# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_18_100648) do
  create_table "histories", force: :cascade do |t|
    t.string "giver_id"
    t.string "receiver_id"
    t.string "receiver_wish"
    t.string "room_name"
    t.string "giver_name"
    t.string "receiver_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", force: :cascade do |t|
    t.string "room_id"
    t.string "user_id"
    t.string "inviter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_users", force: :cascade do |t|
    t.string "room_id"
    t.string "user_id"
    t.string "role"
    t.string "wish"
    t.string "real_username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gift_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "room_name"
    t.string "password_digest"
    t.string "count_of_users"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "user_mail"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
