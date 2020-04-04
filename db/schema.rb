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

ActiveRecord::Schema.define(version: 2020_04_04_134903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "body_statuses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "body_weight", null: false
    t.float "body_fat"
    t.string "picture1"
    t.string "picture2"
    t.string "picture3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_body_statuses_on_user_id"
  end

  create_table "exercise_logs", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.integer "set", null: false
    t.float "weight", null: false
    t.integer "rep", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workout_id"], name: "index_exercise_logs_on_workout_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "part", default: 0, null: false
    t.integer "category", default: 0, null: false
    t.text "description", default: "", null: false
    t.string "icon"
    t.boolean "preset", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_relationships", force: :cascade do |t|
    t.bigint "menu_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_menu_relationships_on_exercise_id"
    t.index ["menu_id"], name: "index_menu_relationships_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", default: "", null: false
    t.string "interval", default: "2", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_menus_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "height"
    t.string "icon"
    t.string "headdre_image"
    t.boolean "public_flag", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "exercise_id"
    t.integer "condition", default: 3, null: false
    t.text "memo", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_workouts_on_exercise_id"
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "body_statuses", "users"
  add_foreign_key "exercise_logs", "workouts"
  add_foreign_key "menu_relationships", "exercises"
  add_foreign_key "menu_relationships", "menus"
  add_foreign_key "menus", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "workouts", "exercises"
  add_foreign_key "workouts", "users"
end
