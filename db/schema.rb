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

ActiveRecord::Schema.define(:version => 20091203115846) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "lemma_id",    :null => false
    t.integer "position"
  end

  add_index "categorizations", ["category_id", "lemma_id"], :name => "index_categories_lemmata_on_category_id_and_lemma_id"
  add_index "categorizations", ["category_id"], :name => "category_id"
  add_index "categorizations", ["lemma_id"], :name => "lemma_id"

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

  add_index "examples", ["exampleable_id", "exampleable_type"], :name => "exampleable_id"
  add_index "examples", ["exampleable_id", "exampleable_type"], :name => "index_examples_on_exampleable_id_and_exampleable_type"

  create_table "lemmata", :force => true do |t|
    t.string   "short1"
    t.string   "short2"
    t.string   "long1"
    t.string   "long2"
    t.string   "phonetic1"
    t.string   "phonetic2"
    t.string   "level_rezeptiv"
    t.string   "level_produktiv"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "synonym1"
    t.string   "synonym2"
    t.string   "word_class1"
    t.string   "word_class2"
    t.string   "gender1"
    t.string   "singular_genitive1"
    t.string   "plural1"
    t.boolean  "singular_only1"
    t.boolean  "collective1"
    t.string   "female_form1"
    t.boolean  "auxiliary1"
    t.string   "present_tense1"
    t.string   "past_tense1"
    t.string   "past_participle1"
    t.boolean  "reflexive1"
    t.boolean  "regular1"
    t.boolean  "irregular1"
    t.boolean  "transitive1"
    t.boolean  "intransitive1"
    t.string   "comparative1"
    t.string   "superlative1"
    t.boolean  "predicative1",        :default => true
    t.boolean  "attributive1",        :default => true
    t.string   "gender2"
    t.string   "singular_genitive2"
    t.string   "plural2"
    t.boolean  "singular_only2"
    t.boolean  "collective2"
    t.string   "female_form2"
    t.boolean  "auxiliary2"
    t.string   "present_tense2"
    t.string   "past_tense2"
    t.string   "past_participle2"
    t.boolean  "reflexive2"
    t.boolean  "regular2"
    t.boolean  "irregular2"
    t.boolean  "transitive2"
    t.boolean  "intransitive2"
    t.string   "comparative2"
    t.string   "superlative2"
    t.boolean  "predicative2",        :default => true
    t.boolean  "attributive2",        :default => true
    t.boolean  "perfekt_haben"
    t.boolean  "perfekt_sein"
    t.boolean  "partikel_trennbar"
    t.boolean  "hat_ge"
    t.string   "present_participle1"
    t.string   "present_participle2"
    t.boolean  "delta",               :default => false
  end

  add_index "lemmata", ["delta"], :name => "index_lemmata_on_delta"

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
