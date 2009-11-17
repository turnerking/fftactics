# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091117032452) do

  create_table "abilities", :force => true do |t|
    t.string   "name"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cost"
  end

  create_table "character_job_abilities", :force => true do |t|
    t.boolean  "completed",        :default => false
    t.integer  "character_job_id"
    t.integer  "ability_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_learn"
  end

  add_index "character_job_abilities", ["character_job_id", "ability_id"], :name => "index_character_job_abilities_on_character_job_id_and_ability_id", :unique => true
  add_index "character_job_abilities", ["character_job_id"], :name => "index_character_job_abilities_on_character_job_id"

  create_table "character_jobs", :force => true do |t|
    t.integer  "character_id"
    t.integer  "job_id"
    t.integer  "job_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "character_jobs", ["job_id", "character_id"], :name => "index_character_jobs_on_job_id_and_character_id", :unique => true

  create_table "characters", :force => true do |t|
    t.string   "gender"
    t.string   "astrological_sign"
    t.string   "name"
    t.integer  "level"
    t.integer  "experience"
    t.integer  "brave"
    t.integer  "faith"
    t.integer  "game_id"
    t.boolean  "main_character",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "base_class"
  end

  create_table "games", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requirements", :force => true do |t|
    t.integer "derived_job_id"
    t.integer "required_job_id"
    t.integer "required_level"
  end

end
