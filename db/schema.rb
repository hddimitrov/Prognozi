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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130722210149) do

  create_table "bets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "matches", :force => true do |t|
    t.string   "host"
    t.string   "guest"
    t.integer  "host_score"
    t.integer  "guest_score"
    t.integer  "tournament_id"
    t.string   "timestamp"
    t.string   "level"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "score_predictions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.integer  "host_score"
    t.integer  "guest_score"
    t.string   "result"
    t.integer  "points"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "team_groups", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "team_id"
    t.integer  "group_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.boolean  "national_team"
    t.integer  "sport_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "tournament_teams", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "team_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.integer  "sport_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_bets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bet_id"
    t.integer  "points"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_rooms", :force => true do |t|
    t.integer  "room_id"
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
