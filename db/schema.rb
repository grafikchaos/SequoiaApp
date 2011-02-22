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

ActiveRecord::Schema.define(:version => 20110222200828) do

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "client_id"
    t.integer  "project_id"
    t.string   "query"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmarks", ["client_id"], :name => "bookmarks_client_id_fk"
  add_index "bookmarks", ["project_id"], :name => "bookmarks_project_id_fk"
  add_index "bookmarks", ["user_id"], :name => "bookmarks_user_id_fk"

  create_table "clients", :force => true do |t|
    t.string   "name",                            :null => false
    t.string   "client_code",       :limit => 10, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cached_slug"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "clients", ["cached_slug"], :name => "index_clients_on_cached_slug"

  create_table "entities", :force => true do |t|
    t.integer  "project_id",                    :null => false
    t.integer  "entity_type_id",                :null => false
    t.string   "name",                          :null => false
    t.integer  "clearance",      :default => 3, :null => false
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entities", ["cached_slug"], :name => "index_entities_on_cached_slug"
  add_index "entities", ["entity_type_id"], :name => "index_entities_on_entity_type_id"
  add_index "entities", ["id"], :name => "index_entities_on_id"
  add_index "entities", ["name"], :name => "index_entities_on_name"
  add_index "entities", ["project_id"], :name => "index_entities_on_project_id"

  create_table "entity_keys", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "cached_slug"
    t.boolean  "mask",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entity_keys", ["cached_slug"], :name => "index_entity_keys_on_cached_slug"
  add_index "entity_keys", ["id"], :name => "index_entity_keys_on_id"
  add_index "entity_keys", ["name"], :name => "index_entity_keys_on_name"

  create_table "entity_rows", :force => true do |t|
    t.integer  "entity_id",       :null => false
    t.integer  "entity_key_id",   :null => false
    t.string   "encrypted_value", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entity_rows", ["encrypted_value"], :name => "index_entity_rows_on_value"
  add_index "entity_rows", ["entity_id"], :name => "index_entity_rows_on_entity_id"
  add_index "entity_rows", ["entity_key_id"], :name => "index_entity_rows_on_entity_key_id"
  add_index "entity_rows", ["id"], :name => "index_entity_rows_on_id"

  create_table "entity_type_aliases", :force => true do |t|
    t.string   "name",           :null => false
    t.integer  "entity_type_id", :null => false
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entity_type_aliases", ["entity_type_id"], :name => "entity_type_aliases_entity_type_id_fk"

  create_table "entity_types", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entity_types", ["cached_slug"], :name => "index_entity_types_on_cached_slug"
  add_index "entity_types", ["id"], :name => "index_entity_types_on_id"
  add_index "entity_types", ["name"], :name => "index_entity_types_on_name"

  create_table "favorites", :force => true do |t|
    t.string   "note",         :limit => 50, :default => ""
    t.integer  "favable_id"
    t.string   "favable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["favable_id"], :name => "index_favorites_on_favable_id"
  add_index "favorites", ["favable_type"], :name => "index_favorites_on_favable_type"
  add_index "favorites", ["user_id"], :name => "index_favorites_on_user_id"

  create_table "projects", :force => true do |t|
    t.integer  "client_id",  :default => 0, :null => false
    t.string   "name",                      :null => false
    t.string   "domain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], :name => "projects_client_id_fk"

  create_table "query_strings", :force => true do |t|
    t.string   "string"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "query_strings", ["string"], :name => "index_query_strings_on_string"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "username",                                                :null => false
    t.string   "role",                :limit => 20,  :default => "staff"
    t.string   "email",                              :default => "",      :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "",      :null => false
    t.string   "password_salt",                      :default => "",      :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "clearance",                          :default => 3,       :null => false
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  add_foreign_key "bookmarks", "clients", :name => "bookmarks_client_id_fk", :dependent => :delete
  add_foreign_key "bookmarks", "projects", :name => "bookmarks_project_id_fk", :dependent => :delete
  add_foreign_key "bookmarks", "users", :name => "bookmarks_user_id_fk", :dependent => :delete

  add_foreign_key "entities", "entity_types", :name => "entities_entity_type_id_fk"
  add_foreign_key "entities", "projects", :name => "entities_project_id_fk", :dependent => :delete

  add_foreign_key "entity_rows", "entities", :name => "entity_rows_entity_id_fk", :dependent => :delete
  add_foreign_key "entity_rows", "entity_keys", :name => "entity_rows_entity_key_id_fk"

  add_foreign_key "entity_type_aliases", "entity_types", :name => "entity_type_aliases_entity_type_id_fk", :dependent => :delete

  add_foreign_key "projects", "clients", :name => "projects_client_id_fk", :dependent => :delete

end
