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

ActiveRecord::Schema.define(:version => 20090310103222) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_lemmata", :id => false, :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "lemma_id",    :null => false
  end

  create_table "collocations", :force => true do |t|
    t.integer  "lemma_id"
    t.string   "form1"
    t.string   "form2"
    t.string   "syntax1"
    t.string   "syntax2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "synonym1"
    t.string   "synonym2"
  end

  create_table "examples", :force => true do |t|
    t.string   "form1"
    t.string   "form2"
    t.integer  "exampleable_id"
    t.string   "exampleable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "synonym1"
    t.string   "synonym2"
  end

  create_table "lemmata", :force => true do |t|
    t.string   "short1"
    t.string   "short2"
    t.string   "long1"
    t.string   "long2"
    t.string   "phonetic1"
    t.string   "phonetic2"
    t.string   "word_class"
    t.string   "level_rezeptiv"
    t.string   "level_produktiv"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phraseologisms", :force => true do |t|
    t.integer  "lemma_id"
    t.string   "form1"
    t.string   "form2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "synonym1"
    t.string   "synonym2"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

  create_table "valencies", :force => true do |t|
    t.integer  "lemma_id"
    t.string   "form1"
    t.string   "form2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "synonym1"
    t.string   "synonym2"
  end

end
