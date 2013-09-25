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

ActiveRecord::Schema.define(:version => 20130923180119) do

  create_table "admins", :force => true do |t|
    t.string   "name",                     :null => false
    t.string   "email",                    :null => false
    t.string   "code",                     :null => false
    t.string   "phone",      :limit => 12, :null => false
    t.date     "age",                      :null => false
    t.boolean  "status"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "adoptions", :force => true do |t|
    t.integer  "theory_id"
    t.integer  "user_id"
    t.integer  "rating"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories_theories", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "theory_id"
  end

  add_index "categories_theories", ["category_id", "theory_id"], :name => "index_categories_theories_on_category_id_and_theory_id"
  add_index "categories_theories", ["category_id"], :name => "index_categories_theories_on_category_id"
  add_index "categories_theories", ["theory_id"], :name => "index_categories_theories_on_theory_id"

  create_table "images", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "imageable_id"
    t.string   "imageable_type"
  end

  create_table "journals", :force => true do |t|
    t.integer  "adoption_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "redactor_assets", :force => true do |t|
    t.integer  "user_id"
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], :name => "idx_redactor_assetable"
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_redactor_assetable_type"

  create_table "theories", :force => true do |t|
    t.string   "title",                                        :null => false
    t.text     "description",                                  :null => false
    t.text     "justification"
    t.text     "brief",                                        :null => false
    t.decimal  "outlay",        :precision => 10, :scale => 2
    t.boolean  "choice",                                       :null => false
    t.boolean  "kind",                                         :null => false
    t.integer  "user_id",                                      :null => false
    t.integer  "view"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",       :limit => 200, :null => false
    t.string   "email",      :limit => 200, :null => false
    t.string   "code"
    t.boolean  "tested"
    t.string   "phone",      :limit => 12
    t.date     "age"
    t.text     "about"
    t.boolean  "admin"
    t.string   "token"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.boolean  "status"
  end

  create_table "votes", :force => true do |t|
    t.boolean  "point"
    t.integer  "user_id"
    t.integer  "theory_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
