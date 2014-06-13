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

ActiveRecord::Schema.define(:version => 20140610205146) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "elimination_phases", :force => true do |t|
    t.integer  "elimination_id"
    t.integer  "team_id"
    t.integer  "opponent_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "elimination_phases", ["elimination_id", "team_id"], :name => "index_eliminations_phase_team_uniq", :unique => true
  add_index "elimination_phases", ["elimination_id"], :name => "index_elimination_phases_on_elimination_id"

  create_table "elimination_predictions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "elimination_id"
    t.integer  "team_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "elimination_predictions", ["user_id", "elimination_id", "team_id"], :name => "index_elimination_predictions_phase_team_uniq", :unique => true
  add_index "elimination_predictions", ["user_id", "elimination_id"], :name => "index_elimination_predictions_on_user_id_and_elimination_id"
  add_index "elimination_predictions", ["user_id"], :name => "index_elimination_predictions_on_user_id"

  create_table "eliminations", :force => true do |t|
    t.integer  "tournament_id"
    t.string   "name"
    t.string   "code"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "group_standing_predictions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "team_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "group_standing_predictions", ["user_id", "group_id", "team_id"], :name => "index_group_standings_predictions_uniq", :unique => true
  add_index "group_standing_predictions", ["user_id", "group_id"], :name => "index_group_standing_predictions_on_user_id_and_group_id"
  add_index "group_standing_predictions", ["user_id"], :name => "index_group_standing_predictions_on_user_id"

  create_table "group_standings", :force => true do |t|
    t.integer  "group_id"
    t.integer  "team_id"
    t.integer  "position",       :default => 0
    t.integer  "matches_played", :default => 0
    t.integer  "matches_won",    :default => 0
    t.integer  "matches_drawn",  :default => 0
    t.integer  "matches_lost",   :default => 0
    t.integer  "goals_for",      :default => 0
    t.integer  "goals_against",  :default => 0
    t.integer  "points",         :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "group_standings", ["group_id", "team_id"], :name => "index_group_standings_on_group_id_and_team_id", :unique => true
  add_index "group_standings", ["group_id"], :name => "index_group_standings_on_group_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "tournament_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "match_predictions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.integer  "host_score"
    t.integer  "guest_score"
    t.string   "sign"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "match_predictions", ["user_id", "match_id"], :name => "index_match_predictions_on_user_id_and_match_id", :unique => true
  add_index "match_predictions", ["user_id"], :name => "index_match_predictions_on_user_id"

  create_table "matches", :force => true do |t|
    t.string   "phase_type"
    t.integer  "phase_id"
    t.integer  "host_id"
    t.integer  "guest_id"
    t.integer  "host_score"
    t.integer  "guest_score"
    t.string   "sign"
    t.datetime "start_at"
    t.integer  "code"
    t.string   "location"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "prediction_points", :force => true do |t|
    t.integer  "user_id"
    t.string   "prediction_type"
    t.integer  "prediction_id"
    t.float    "points"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "prediction_points", ["user_id"], :name => "index_prediction_points_on_user_id"
  add_index "prediction_points", ["user_id"], :name => "index_prediction_points_on_user_id_and_room_id"

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.integer  "tournament_id"
    t.integer  "creator_id"
    t.boolean  "q_public",             :default => false
    t.float    "m_score_points"
    t.float    "m_sign_points"
    t.float    "gs_position_1_points"
    t.float    "e_ef_points"
    t.float    "e_qf_points"
    t.float    "e_sf_points"
    t.float    "e_l_points"
    t.float    "e_f_points"
    t.float    "e_c_points"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "sqlite_sp_functions", :id => false, :force => true do |t|
    t.text "name"
    t.text "text"
  end

# Could not dump table "sqlite_stat1" because of following StandardError
#   Unknown type '' for column 'tbl'

# Could not dump table "sqlite_stat4" because of following StandardError
#   Unknown type '' for column 'tbl'

  create_table "sqlite_vs_links_names", :id => false, :force => true do |t|
    t.text "name"
    t.text "alias"
  end

  create_table "sqlite_vs_properties", :id => false, :force => true do |t|
    t.text "parentType"
    t.text "parentName"
    t.text "propertyName"
    t.text "propertyValue"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "flag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "top_scorer_predictions", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "top_scorer_predictions", ["user_id"], :name => "index_top_scorer_predictions_on_user_id", :unique => true

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_rooms", :force => true do |t|
    t.integer  "room_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                    :default => "",   :null => false
    t.string   "encrypted_password",       :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "name"
    t.string   "referer_name"
    t.float    "group_phase_points",       :default => 0.0
    t.float    "elimination_phase_points", :default => 0.0
    t.boolean  "q_active",                 :default => true
    t.string   "token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
