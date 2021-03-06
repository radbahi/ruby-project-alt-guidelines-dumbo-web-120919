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

ActiveRecord::Schema.define(version: 2019_12_22_210517) do

  create_table "betters", force: :cascade do |t|
    t.string "name"
    t.float "bet_amount", default: 0.0
    t.string "bet_on"
    t.integer "fighter_id"
    t.integer "match_id"
  end

  create_table "fighters", force: :cascade do |t|
    t.string "name"
    t.integer "health", default: 100
    t.float "bet_pot", default: 0.0
    t.integer "better_id"
    t.integer "match_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "fighter_one"
    t.string "fighter_two"
    t.integer "better_id"
    t.integer "fighter_id"
    t.float "bet_pool", default: 0.0
    t.string "winner"
    t.string "loser"
  end

end
