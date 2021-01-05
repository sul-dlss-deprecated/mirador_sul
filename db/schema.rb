# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_21_231602) do

  create_table "annotations", force: :cascade do |t|
    t.integer "user_id"
    t.string "uuid"
    t.string "canvas"
    t.binary "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["canvas"], name: "index_annotations_on_canvas"
    t.index ["user_id"], name: "index_annotations_on_user_id"
    t.index ["uuid"], name: "index_annotations_on_uuid"
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "workspaces_count", default: 0
    t.text "description"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "collections_manifests", id: false, force: :cascade do |t|
    t.integer "collection_id", null: false
    t.integer "manifest_id", null: false
    t.index ["collection_id", "manifest_id"], name: "index_collections_manifests_on_collection_id_and_manifest_id"
    t.index ["collection_id"], name: "index_collections_manifests_on_collection_id"
    t.index ["manifest_id", "collection_id"], name: "index_collections_manifests_on_manifest_id_and_collection_id"
    t.index ["manifest_id"], name: "index_collections_manifests_on_manifest_id"
  end

  create_table "manifests", force: :cascade do |t|
    t.string "url", limit: 4000
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_manifests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name"
    t.binary "data", limit: 64000
    t.integer "collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.text "description"
    t.boolean "public", default: false, null: false
    t.index ["collection_id"], name: "index_workspaces_on_collection_id"
    t.index ["public"], name: "index_workspaces_on_public"
    t.index ["user_id"], name: "index_workspaces_on_user_id"
  end

  add_foreign_key "annotations", "users"
  add_foreign_key "collections", "users"
  add_foreign_key "collections_manifests", "collections"
  add_foreign_key "collections_manifests", "manifests"
  add_foreign_key "manifests", "users"
  add_foreign_key "workspaces", "collections", on_delete: :nullify
end
