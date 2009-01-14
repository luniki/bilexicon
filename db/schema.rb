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

ActiveRecord::Schema.define(:version => 20090113090324) do

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

  create_table "examples", :force => true do |t|
    t.string   "form1"
    t.string   "form2"
    t.integer  "exampleable_id"
    t.string   "exampleable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lemmata", :force => true do |t|
    t.string   "short1"
    t.string   "short2"
    t.string   "long1"
    t.string   "long2"
    t.string   "phonetic1"
    t.string   "phonetic2"
    t.string   "class1"
    t.string   "class2"
    t.string   "level1"
    t.string   "level2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
