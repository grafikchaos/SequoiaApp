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

ActiveRecord::Schema.define(:version => 0) do

  create_table "clients", :force => true do |t|
    t.string    "name",        :limit => 128, :null => false
    t.string    "client_code", :limit => 10,  :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "entities", :force => true do |t|
    t.integer   "project_id",     :null => false
    t.integer   "entity_type_id", :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "entities", ["entity_type_id"], :name => "fk_entities_entity_types1"
  add_index "entities", ["project_id"], :name => "fk_entities_projects1"

  create_table "entity_attributes", :force => true do |t|
    t.string    "name",       :limit => 45, :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "entity_types", :force => true do |t|
    t.string    "name",       :limit => 45, :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "entity_values", :force => true do |t|
    t.integer   "entity_id",                         :null => false
    t.integer   "entity_attribute_id",               :null => false
    t.string    "value",               :limit => 45
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "entity_values", ["entity_attribute_id"], :name => "fk_entity_values_entity_attributes1"
  add_index "entity_values", ["entity_id"], :name => "fk_entity_values_entities1"

  create_table "project_has_software", :force => true do |t|
    t.integer   "project_id",  :null => false
    t.integer   "software_id", :null => false
    t.integer   "version_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "project_has_software", ["project_id"], :name => "fk_project_has_software_projects1"
  add_index "project_has_software", ["software_id"], :name => "fk_project_has_software_software"
  add_index "project_has_software", ["version_id"], :name => "fk_project_has_software_software_versions1"

  create_table "projects", :force => true do |t|
    t.integer   "client_id",                :null => false
    t.string    "name",       :limit => 45, :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "projects", ["client_id"], :name => "fk_projects_clients1"

  create_table "software", :force => true do |t|
    t.integer   "software_type_id",               :null => false
    t.string    "name",             :limit => 45, :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "software", ["software_type_id"], :name => "fk_software_software_types1"

  create_table "software_types", :force => true do |t|
    t.string    "name",       :limit => 45, :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "software_versions", :force => true do |t|
    t.integer   "software_id",               :null => false
    t.string    "version",     :limit => 20, :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "software_versions", ["software_id"], :name => "fk_software_versions_software1"

  create_table "users", :force => true do |t|
    t.string    "role",            :limit => 45,  :null => false
    t.string    "username",        :limit => 45,  :null => false
    t.string    "email",           :limit => 45,  :null => false
    t.string    "hashed_password", :limit => 128, :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

end
