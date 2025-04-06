# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_06_183852) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attractions", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "country"
    t.string "season"
    t.boolean "bus"
    t.boolean "plane"
    t.boolean "train"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ship"
    t.string "description"
    t.integer "views_count"
  end

  create_table "destinations", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.boolean "plane"
    t.boolean "train"
    t.boolean "ship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.string "name_stay"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.string "name_stay"
    t.integer "days_counter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "code_taxi"
    t.string "name_auto"
    t.date "check_in"
    t.date "check_out"
    t.integer "people"
    t.integer "user"
  end

  create_table "stays", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "country"
    t.boolean "family"
    t.boolean "job"
    t.boolean "group"
    t.boolean "bus"
    t.boolean "train"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stay_type"
    t.string "description"
    t.bigint "tel"
    t.bigint "user_id"
    t.integer "views_count"
  end

  create_table "taxis", force: :cascade do |t|
    t.integer "code"
    t.datetime "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "partenza"
    t.string "arrivo"
    t.bigint "user_id"
    t.integer "duration"
    t.index ["user_id"], name: "index_taxis_on_user_id"
  end

  create_table "transports", force: :cascade do |t|
    t.string "name"
    t.string "plate"
    t.boolean "rented"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
  end

  create_table "travels", force: :cascade do |t|
    t.string "name_stay"
    t.integer "people"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.string "provider"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.boolean "business", default: false, null: false
    t.boolean "newsletter"
    t.string "cancel_account_token"
    t.datetime "cancel_account_sent_at"
    t.string "confirmation_token"
    t.string "confirmed_at"
    t.string "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "upgrade_token"
    t.datetime "upgrade_token_sent_at"
    t.string "phone_number"
    t.boolean "discount_notifications"
    t.boolean "structure_notifications"
    t.string "encrypted_card_number"
    t.string "encrypted_card_expiry"
    t.string "encrypted_card_cvc"
    t.string "encrypted_card_number_iv"
    t.string "encrypted_card_expiry_iv"
    t.string "encrypted_card_cvc_iv"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.string "user"
    t.string "name_stay"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stay_id"
    t.decimal "price"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "stays", "users", on_delete: :nullify
end
