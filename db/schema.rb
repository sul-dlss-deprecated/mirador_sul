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

ActiveRecord::Schema.define(version: 20170323233851) do

  create_table "collections", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "collections_manifests", id: false, force: :cascade do |t|
    t.integer "collection_id"
    t.integer "manifest_id"
    t.index ["collection_id", "manifest_id"], name: "index_collections_manifests_on_collection_id_and_manifest_id"
    t.index ["collection_id"], name: "index_collections_manifests_on_collection_id"
    t.index ["manifest_id"], name: "index_collections_manifests_on_manifest_id"
  end

  create_table "manifests", force: :cascade do |t|
    t.string   "url",        limit: 4000
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["user_id"], name: "index_manifests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "workspaces", force: :cascade do |t|
    t.string   "name"
    t.binary   "data",          limit: 64000
    t.integer  "collection_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["collection_id"], name: "index_workspaces_on_collection_id"
  end

end
