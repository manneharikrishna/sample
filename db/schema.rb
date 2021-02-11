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

ActiveRecord::Schema.define(version: 20210208233908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "accountants", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consultants", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "drawing_transitions", id: :serial, force: :cascade do |t|
    t.string "to_state", null: false
    t.json "metadata", default: {}
    t.integer "sort_key", null: false
    t.integer "drawing_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drawing_id", "most_recent"], name: "index_drawing_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["drawing_id", "sort_key"], name: "index_drawing_transitions_parent_sort", unique: true
    t.index ["to_state"], name: "index_drawing_transitions_on_to_state"
  end

  create_table "drawings", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lottery_id"
    t.index ["lottery_id"], name: "index_drawings_on_lottery_id"
  end

  create_table "entries", id: :serial, force: :cascade do |t|
    t.integer "drawing_id"
    t.integer "player_id"
    t.integer "photo_id"
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tickets_count", default: 1
    t.string "entry_type"
    t.datetime "revealed_at"
    t.index ["drawing_id"], name: "index_entries_on_drawing_id"
    t.index ["entry_type"], name: "index_entries_on_entry_type"
    t.index ["photo_id"], name: "index_entries_on_photo_id"
    t.index ["player_id"], name: "index_entries_on_player_id"
  end

  create_table "failed_session_attempts", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "counter", default: 0
  end

  create_table "licenses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "lottery_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_duration"
    t.integer "max_duration"
    t.integer "max_tickets_count"
    t.decimal "max_total_revenue", precision: 12, scale: 2
    t.integer "min_payback_ratio"
    t.integer "max_payback_ratio"
  end

  create_table "lotteries", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "headline"
    t.string "description"
    t.string "cover"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer "tickets_count"
    t.decimal "ticket_price", precision: 8, scale: 2
    t.integer "payback_ratio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "license_id"
    t.integer "repeat_every"
    t.index ["license_id"], name: "index_lotteries_on_license_id"
  end

  create_table "lottery_transitions", id: :serial, force: :cascade do |t|
    t.string "to_state", null: false
    t.json "metadata", default: {}
    t.integer "sort_key", null: false
    t.integer "lottery_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lottery_id", "most_recent"], name: "index_lottery_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["lottery_id", "sort_key"], name: "index_lottery_transitions_parent_sort", unique: true
  end

  create_table "operators", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_operators_on_email", unique: true
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player_id"
    t.boolean "visible", default: true
    t.index ["player_id"], name: "index_photos_on_player_id"
  end

  create_table "players", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "activated_at"
    t.string "avatar"
    t.datetime "suspended_until"
    t.date "birthdate"
    t.string "bank_account_number"
    t.integer "weekly_loss_limit"
    t.integer "daily_loss_limit"
    t.string "language"
    t.string "ssn"
    t.integer "twenty_four_seven_office_id"
    t.boolean "is_pep", default: false
    t.datetime "deactivated_at"
    t.boolean "onboarding", default: false
    t.boolean "information", default: true
    t.integer "last_entry_id"
    t.json "player_info", default: {}
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["last_entry_id"], name: "index_players_on_last_entry_id"
    t.index ["ssn"], name: "index_players_on_ssn", unique: true
  end

  create_table "prizes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.decimal "value", precision: 12, scale: 2
    t.string "reveal_type", default: "instant", null: false
    t.string "prizeable_type"
    t.integer "prizeable_id"
    t.index ["prizeable_type", "prizeable_id"], name: "index_prizes_on_prizeable_type_and_prizeable_id"
  end

  create_table "regulators", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_regulators_on_email", unique: true
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.integer "photo_id"
    t.integer "tickets_count"
    t.string "status", default: "inactive"
    t.string "payment_method"
    t.string "card_expiration_date"
    t.string "card_last_digits"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expires_on"
    t.index ["photo_id"], name: "index_subscriptions_on_photo_id"
    t.index ["player_id"], name: "index_subscriptions_on_player_id"
    t.index ["status"], name: "index_subscriptions_on_status"
  end

  create_table "success_session_attempts", id: :serial, force: :cascade do |t|
    t.integer "counter", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_autoreveals", id: :serial, force: :cascade do |t|
    t.integer "ticket_id"
    t.string "ticket_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_ticket_autoreveals_on_ticket_id"
  end

  create_table "tickets", id: :serial, force: :cascade do |t|
    t.integer "drawing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "prize_id"
    t.integer "entry_id"
    t.uuid "serial_number", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "revealed_at"
    t.json "scratch_state", default: {}
    t.index ["drawing_id"], name: "index_tickets_on_drawing_id"
    t.index ["entry_id"], name: "index_tickets_on_entry_id"
    t.index ["prize_id"], name: "index_tickets_on_prize_id"
  end

  create_table "transactions", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.string "type"
    t.decimal "amount", precision: 12, scale: 2
    t.jsonb "data", default: {}
    t.integer "entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "completed"
    t.integer "subscription_id"
    t.index ["entry_id"], name: "index_transactions_on_entry_id"
    t.index ["player_id"], name: "index_transactions_on_player_id"
    t.index ["subscription_id"], name: "index_transactions_on_subscription_id"
  end

  create_table "winnings", id: :serial, force: :cascade do |t|
    t.integer "drawing_id"
    t.integer "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drawing_id"], name: "index_winnings_on_drawing_id"
    t.index ["ticket_id"], name: "index_winnings_on_ticket_id"
  end

  add_foreign_key "drawings", "lotteries"
  add_foreign_key "entries", "drawings"
  add_foreign_key "entries", "players"
  add_foreign_key "lotteries", "licenses"
  add_foreign_key "photos", "players"
  add_foreign_key "players", "entries", column: "last_entry_id"
  add_foreign_key "subscriptions", "photos"
  add_foreign_key "subscriptions", "players"
  add_foreign_key "ticket_autoreveals", "tickets"
  add_foreign_key "tickets", "drawings"
  add_foreign_key "tickets", "entries"
  add_foreign_key "tickets", "prizes"
  add_foreign_key "transactions", "entries"
  add_foreign_key "transactions", "players"
  add_foreign_key "transactions", "subscriptions"
  add_foreign_key "winnings", "drawings"
end
