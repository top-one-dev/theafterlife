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

ActiveRecord::Schema.define(version: 20170711184732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_movements", force: :cascade do |t|
    t.bigint "member_id"
    t.decimal "amount", precision: 30, scale: 8
    t.decimal "confirmed_amount", precision: 30, scale: 8
    t.datetime "paid_at"
    t.string "uuid"
    t.string "payment_type"
    t.string "payment_identificator"
    t.string "payment_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_account_movements_on_member_id"
    t.index ["uuid"], name: "index_account_movements_on_uuid"
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "addressable_id"
    t.string "addressable_type"
    t.string "name"
    t.string "address"
    t.string "street_number"
    t.string "route"
    t.string "neighborhood"
    t.string "sublocality"
    t.string "administrative_area_level_1"
    t.string "administrative_area_level_2"
    t.string "country"
    t.string "postal_code"
    t.decimal "lat", precision: 10, scale: 7
    t.decimal "lng", precision: 10, scale: 7
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "bodies", force: :cascade do |t|
    t.bigint "member_id"
    t.boolean "donate_organs"
    t.string "ceremony_type"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_bodies_on_member_id"
  end

  create_table "burial_services", force: :cascade do |t|
    t.bigint "member_id"
    t.boolean "enabled"
    t.string "plot"
    t.boolean "symbolic_goodbye"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_burial_services_on_member_id"
  end

  create_table "cremations", force: :cascade do |t|
    t.bigint "member_id"
    t.boolean "enabled"
    t.string "ashes_disposition"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_cremations_on_member_id"
  end

  create_table "funeral_services", force: :cascade do |t|
    t.bigint "member_id"
    t.boolean "enabled"
    t.string "public"
    t.string "color_themes"
    t.string "ideal_funeral"
    t.string "music"
    t.string "flowers"
    t.string "food_drinks"
    t.text "reading"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_funeral_services_on_member_id"
  end

  create_table "headstones", force: :cascade do |t|
    t.bigint "member_id"
    t.boolean "enabled"
    t.text "epitaph"
    t.boolean "individual"
    t.string "material"
    t.string "flower_vase"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_headstones_on_member_id"
  end

  create_table "letters", force: :cascade do |t|
    t.bigint "member_id"
    t.text "text"
    t.date "date_of_creation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_letters_on_member_id"
  end

  create_table "member_files", force: :cascade do |t|
    t.bigint "member_id"
    t.string "name"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.index ["member_id"], name: "index_member_files_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name"
    t.string "last_name"
    t.index ["confirmation_token"], name: "index_members_on_confirmation_token", unique: true
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_members_on_unlock_token", unique: true
  end

  create_table "memorial_contributions", force: :cascade do |t|
    t.bigint "member_id"
    t.boolean "enabled"
    t.string "sent_to"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_memorial_contributions_on_member_id"
  end

  create_table "memorial_markers", force: :cascade do |t|
    t.bigint "member_id"
    t.boolean "enabled"
    t.string "mm_type"
    t.text "writing"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_memorial_markers_on_member_id"
  end

  create_table "memories", force: :cascade do |t|
    t.bigint "member_id"
    t.integer "order"
    t.string "heading"
    t.text "text"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_memories_on_member_id"
  end

  create_table "musics", force: :cascade do |t|
    t.bigint "member_id"
    t.string "artist"
    t.string "title"
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_musics_on_member_id"
  end

  create_table "obituaries", force: :cascade do |t|
    t.bigint "member_id"
    t.boolean "enabled"
    t.datetime "birth_day"
    t.string "birth_place"
    t.text "schools"
    t.text "career"
    t.text "activities"
    t.text "remember_me_for"
    t.text "other"
    t.string "where_to_publish"
    t.text "my_obituary"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_obituaries_on_member_id"
  end

  create_table "payment_errors", force: :cascade do |t|
    t.bigint "account_movement_id"
    t.string "error_type"
    t.string "error_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_movement_id"], name: "index_payment_errors_on_account_movement_id"
  end

  create_table "payment_plans", force: :cascade do |t|
    t.bigint "member_id"
    t.string "interval"
    t.decimal "amount", precision: 30, scale: 8
    t.datetime "started_at"
    t.datetime "cancelled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_payment_plans_on_member_id"
  end

  create_table "people", force: :cascade do |t|
    t.bigint "member_id"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "relation"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_people_on_member_id"
  end

  create_table "person_roles", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_person_roles_on_person_id"
    t.index ["role_id"], name: "index_person_roles_on_role_id"
  end

  create_table "pets", force: :cascade do |t|
    t.bigint "member_id"
    t.string "name"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_pets_on_member_id"
  end

  create_table "photo_galleries", force: :cascade do |t|
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_photo_galleries_on_member_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "member_id"
    t.integer "imageable_id"
    t.string "imageable_type"
    t.text "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.index ["member_id"], name: "index_photos_on_member_id"
  end

  create_table "possessions", force: :cascade do |t|
    t.bigint "member_id"
    t.string "what"
    t.string "who"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_possessions_on_member_id"
  end

  create_table "programs", force: :cascade do |t|
    t.bigint "member_id"
    t.string "design"
    t.text "text_on_cover"
    t.text "words_i_want_to_included"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_programs_on_member_id"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "question_id"
    t.text "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_questionnaires_on_member_id"
    t.index ["question_id"], name: "index_questionnaires_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receptions", force: :cascade do |t|
    t.bigint "member_id"
    t.boolean "enabled"
    t.text "food"
    t.text "drink"
    t.text "music"
    t.text "flowers"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_receptions_on_member_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "science_donations", force: :cascade do |t|
    t.bigint "member_id"
    t.boolean "enabled"
    t.string "organization_name"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_science_donations_on_member_id"
  end

  create_table "sensitive_infos", force: :cascade do |t|
    t.bigint "member_id"
    t.string "info_type"
    t.string "title"
    t.string "instruction"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_sensitive_infos_on_member_id"
  end

  create_table "social_accounts", force: :cascade do |t|
    t.bigint "member_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_social_accounts_on_member_id"
  end

  create_table "transportations", force: :cascade do |t|
    t.bigint "member_id"
    t.string "transport_of_deceased"
    t.string "transport_of_family"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_transportations_on_member_id"
  end

  create_table "visitations", force: :cascade do |t|
    t.bigint "member_id"
    t.boolean "enabled"
    t.string "public"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_visitations_on_member_id"
  end

  create_table "writings", force: :cascade do |t|
    t.bigint "member_id"
    t.string "author"
    t.string "title"
    t.text "text"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_writings_on_member_id"
  end

  add_foreign_key "account_movements", "members"
  add_foreign_key "bodies", "members"
  add_foreign_key "burial_services", "members"
  add_foreign_key "cremations", "members"
  add_foreign_key "funeral_services", "members"
  add_foreign_key "headstones", "members"
  add_foreign_key "letters", "members"
  add_foreign_key "member_files", "members"
  add_foreign_key "memorial_contributions", "members"
  add_foreign_key "memorial_markers", "members"
  add_foreign_key "memories", "members"
  add_foreign_key "musics", "members"
  add_foreign_key "obituaries", "members"
  add_foreign_key "payment_errors", "account_movements"
  add_foreign_key "payment_plans", "members"
  add_foreign_key "people", "members"
  add_foreign_key "person_roles", "people"
  add_foreign_key "person_roles", "roles"
  add_foreign_key "pets", "members"
  add_foreign_key "photo_galleries", "members"
  add_foreign_key "photos", "members"
  add_foreign_key "possessions", "members"
  add_foreign_key "programs", "members"
  add_foreign_key "questionnaires", "members"
  add_foreign_key "questionnaires", "questions"
  add_foreign_key "receptions", "members"
  add_foreign_key "science_donations", "members"
  add_foreign_key "sensitive_infos", "members"
  add_foreign_key "social_accounts", "members"
  add_foreign_key "transportations", "members"
  add_foreign_key "visitations", "members"
  add_foreign_key "writings", "members"
end
