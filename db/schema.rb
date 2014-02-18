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

ActiveRecord::Schema.define(:version => 20140218223537) do

  create_table "addresses", :force => true do |t|
    t.string   "address_line",     :null => false
    t.string   "city",             :null => false
    t.string   "state",            :null => false
    t.integer  "zip_code",         :null => false
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "addresses", ["zip_code"], :name => "index_addresses_on_zip_code"

  create_table "event_signups", :force => true do |t|
    t.integer  "attendee_id", :null => false
    t.integer  "event_id",    :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "event_signups", ["attendee_id", "event_id"], :name => "index_event_signups_on_attendee_id_and_event_id", :unique => true

  create_table "events", :force => true do |t|
    t.string   "title",               :null => false
    t.string   "description",         :null => false
    t.datetime "date",                :null => false
    t.integer  "group_id",            :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "events", ["group_id"], :name => "index_events_on_group_id"

  create_table "group_memberships", :force => true do |t|
    t.integer  "member_id",  :null => false
    t.integer  "group_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "group_memberships", ["member_id", "group_id"], :name => "index_group_memberships_on_member_id_and_group_id", :unique => true

  create_table "groups", :force => true do |t|
    t.string   "title",       :null => false
    t.string   "description", :null => false
    t.integer  "owner_id",    :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "interests", :force => true do |t|
    t.string   "title",      :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "interests", ["user_id"], :name => "index_interests_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",               :null => false
    t.string   "password_digest",     :null => false
    t.string   "name",                :null => false
    t.date     "birthday"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "authenticity_token",  :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
