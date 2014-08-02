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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140801094233) do

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.decimal  "price",      precision: 12, scale: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_notes", force: true do |t|
    t.integer "user_id"
    t.integer "note_id"
  end

  add_index "favorite_notes", ["user_id", "note_id"], name: "index_favorite_notes_on_user_id_and_note_id", unique: true, using: :btree

  create_table "note_types", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.text     "short_body"
    t.integer  "user_id"
    t.integer  "note_type_id"
    t.integer  "comment_count",                            default: 0
    t.decimal  "price_for_access", precision: 8, scale: 2, default: 0.0
    t.decimal  "decimal",          precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["note_type_id"], name: "index_notes_on_note_type_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "payments", force: true do |t|
    t.integer  "user_id",                                                               null: false
    t.integer  "note_id",                                                               null: false
    t.integer  "status",                                                                null: false
    t.boolean  "settled",                                               default: false
    t.string   "custom",            limit: 40,                                          null: false
    t.decimal  "price",                        precision: 12, scale: 8, default: 0.0
    t.string   "coinbase_order_id"
    t.string   "transaction_hash"
    t.decimal  "transaction_fee",              precision: 12, scale: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["coinbase_order_id"], name: "index_payments_on_coinbase_order_id", unique: true, using: :btree
  add_index "payments", ["custom"], name: "index_payments_on_custom", unique: true, using: :btree
  add_index "payments", ["note_id"], name: "index_payments_on_note_id", using: :btree
  add_index "payments", ["transaction_hash"], name: "index_payments_on_transaction_hash", unique: true, using: :btree
  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "purchased_notes", force: true do |t|
    t.integer  "user_id"
    t.integer  "note_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchased_notes", ["user_id", "note_id"], name: "index_purchased_notes_on_user_id_and_note_id", unique: true, using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "user_name",              limit: 50,              null: false
    t.string   "bitcoin_wallet",         limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true, using: :btree

end
