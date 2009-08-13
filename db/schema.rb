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

ActiveRecord::Schema.define(:version => 20090813074510) do

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

  add_index "categories_lemmata", ["category_id", "lemma_id"], :name => "index_categories_lemmata_on_category_id_and_lemma_id"

  create_table "examples", :force => true do |t|
    t.string   "form1"
    t.string   "form2"
    t.string   "synonym1"
    t.string   "synonym2"
    t.string   "syntax1"
    t.string   "syntax2"
    t.integer  "exampleable_id"
    t.string   "exampleable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "examples", ["exampleable_id", "exampleable_type"], :name => "index_examples_on_exampleable_id_and_exampleable_type"

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

  create_table "subentries", :force => true do |t|
    t.integer  "lemma_id"
    t.string   "type"
    t.string   "form1"
    t.string   "form2"
    t.string   "syntax1"
    t.string   "syntax2"
    t.string   "synonym1"
    t.string   "synonym2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "subentries", ["lemma_id", "type"], :name => "index_subentries_on_lemma_id_and_type"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                            :null => false
    t.string   "crypted_password",                 :null => false
    t.string   "password_salt",                    :null => false
    t.string   "persistence_token",                :null => false
    t.integer  "login_count",       :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.boolean  "admin"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
