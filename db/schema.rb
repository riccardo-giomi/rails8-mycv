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

ActiveRecord::Schema[8.1].define(version: 2026_01_31_100018) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.string "contact_type", default: "generic", null: false
    t.datetime "created_at", null: false
    t.integer "cv_id", null: false
    t.integer "position", default: 1
    t.datetime "updated_at", null: false
    t.string "value"
    t.index ["cv_id"], name: "index_contacts_on_cv_id"
  end

  create_table "cover_letters", force: :cascade do |t|
    t.boolean "active"
    t.string "company_name"
    t.string "company_url"
    t.text "content"
    t.datetime "created_at", null: false
    t.string "job_url"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "cvs", force: :cascade do |t|
    t.string "base_filename"
    t.datetime "created_at", null: false
    t.string "education_label", default: "Education"
    t.string "email_address"
    t.string "intro_line"
    t.text "intro_text"
    t.string "intro_text_label", default: "Career Summary"
    t.string "language"
    t.string "languages_label", default: "Languages"
    t.string "name"
    t.string "notes"
    t.datetime "updated_at", null: false
    t.string "work_experience_continued_label", default: "Work Experience (continued)"
    t.string "work_experience_continues_label", default: "(Continued in the next page)"
    t.string "work_experience_label", default: "Work Experience"
  end

  create_table "education_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "cv_id", null: false
    t.string "date"
    t.string "location"
    t.string "name"
    t.integer "position", default: 1
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_education_items_on_cv_id"
  end

  create_table "languages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "cv_id", null: false
    t.string "level"
    t.string "name"
    t.integer "position", default: 1
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_languages_on_cv_id"
  end

  create_table "layouts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "cv_id", null: false
    t.text "page_breaks"
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_layouts_on_cv_id", unique: true
  end

  create_table "work_experiences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "cv_id", null: false
    t.text "description"
    t.string "entity"
    t.string "entity_uri"
    t.string "period"
    t.integer "position"
    t.string "tags"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_work_experiences_on_cv_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "contacts", "cvs"
  add_foreign_key "education_items", "cvs"
  add_foreign_key "languages", "cvs"
  add_foreign_key "layouts", "cvs"
  add_foreign_key "work_experiences", "cvs"
end
