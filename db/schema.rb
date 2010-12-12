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

ActiveRecord::Schema.define(:version => 20101207024537) do

  create_table "clients", :force => true do |t|
    t.string    "name",        :limit => 128, :null => false
    t.string    "client_code", :limit => 10,  :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.integer   "client_id",                :null => false
    t.string    "name",       :limit => 45, :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "projects", ["client_id"], :name => "fk_projects_clients1"

  create_table "users", :force => true do |t|
    t.string    "role",            :limit => 45,  :null => false
    t.string    "username",        :limit => 45,  :null => false
    t.string    "email",           :limit => 45,  :null => false
    t.string    "hashed_password", :limit => 128, :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

end
