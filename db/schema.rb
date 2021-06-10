# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_09_071510) do

  create_table "deliveries", force: :cascade do |t|
    t.string "address"
    t.integer "meal_id"
    t.integer "user_id"
    t.boolean "delivered"
    t.decimal "tip"
    t.float "price"
  end

  create_table "item_meals", force: :cascade do |t|
    t.integer "meal_id"
    t.integer "item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "food_group"
    t.string "description"
    t.float "price"
  end

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.integer "times_purchased"
    t.float "price"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "email"
    t.string "password_digest"
    t.decimal "credit"
    t.boolean "admin"
    t.string "uid"
    t.string "provider"
  end

end
