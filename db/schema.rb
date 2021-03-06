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

ActiveRecord::Schema.define(:version => 20120708021503) do

  create_table "board_pics", :force => true do |t|
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.datetime  "image_updated_at"
    t.timestamp "created_at",         :limit => 3, :null => false
    t.timestamp "updated_at",         :limit => 3, :null => false
    t.integer   "user_id"
    t.integer   "group_id"
    t.date      "class_date"
  end

  create_table "books", :force => true do |t|
    t.integer   "user_id"
    t.integer   "group_id"
    t.string    "title"
    t.string    "author"
    t.string    "publisher"
    t.boolean   "available",                                                  :default => true, :null => false
    t.text      "additional_info"
    t.text      "contact_info"
    t.timestamp "created_at",      :limit => 3,                                                 :null => false
    t.timestamp "updated_at",      :limit => 3,                                                 :null => false
    t.string    "offer_type"
    t.decimal   "price",                        :precision => 5, :scale => 2
  end

  create_table "enrollments", :force => true do |t|
    t.string    "user_email"
    t.integer   "group_id"
    t.timestamp "created_at", :limit => 3, :null => false
    t.timestamp "updated_at", :limit => 3, :null => false
    t.integer   "user_id"
  end

  create_table "feedbacks", :force => true do |t|
    t.text      "text"
    t.timestamp "created_at", :limit => 3, :null => false
    t.timestamp "updated_at", :limit => 3, :null => false
    t.integer   "user_id"
  end

  create_table "groups", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :limit => 3, :null => false
    t.timestamp "updated_at", :limit => 3, :null => false
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id", :null => false
    t.integer "user_id",  :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer   "user_id"
    t.integer   "group_id"
    t.string    "text"
    t.timestamp "created_at", :limit => 3, :null => false
    t.timestamp "updated_at", :limit => 3, :null => false
  end

  create_table "replies", :force => true do |t|
    t.integer   "post_id"
    t.integer   "user_id"
    t.text      "text"
    t.timestamp "created_at", :limit => 3, :null => false
    t.timestamp "updated_at", :limit => 3, :null => false
    t.string    "post_type"
  end

  create_table "users", :force => true do |t|
    t.string    "email",                                 :default => "",    :null => false
    t.string    "encrypted_password",                    :default => "",    :null => false
    t.string    "reset_password_token"
    t.datetime  "reset_password_sent_at"
    t.datetime  "remember_created_at"
    t.integer   "sign_in_count",                         :default => 0
    t.datetime  "current_sign_in_at"
    t.datetime  "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.string    "confirmation_token"
    t.datetime  "confirmed_at"
    t.datetime  "confirmation_sent_at"
    t.string    "unconfirmed_email"
    t.string    "authentication_token"
    t.timestamp "created_at",               :limit => 3,                    :null => false
    t.timestamp "updated_at",               :limit => 3,                    :null => false
    t.string    "name"
    t.boolean   "admin",                                 :default => false, :null => false
    t.string    "profile_pic_file_name"
    t.string    "profile_pic_content_type"
    t.integer   "profile_pic_file_size"
    t.datetime  "profile_pic_updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "enrollments", "groups", :name => "enrollments_group_id_fk"
  add_foreign_key "enrollments", "users", :name => "enrollments_user_id_fk"

end
