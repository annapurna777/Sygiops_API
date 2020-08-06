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

ActiveRecord::Schema.define(version: 2020_06_03_071303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "sygiops_support_calendars", force: :cascade do |t|
    t.string "name", limit: 250
    t.string "timezone", limit: 250
    t.string "business_hours", limit: 3000
    t.boolean "default_create", default: false, null: false
    t.string "ical_url", limit: 500
    t.text "public_holidays"
    t.text "last_log"
    t.datetime "last_sync", precision: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sygiops_support_channels", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.string "preferences", limit: 2000
    t.text "last_log_in"
    t.text "last_log_out"
    t.string "status_in", limit: 100
    t.string "status_out", limit: 100
    t.string "area", limit: 2000
    t.string "options", limit: 2000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sygiops_support_email_addresses", force: :cascade do |t|
    t.integer "channel_id"
    t.string "realname", limit: 250, null: false
    t.string "email", limit: 250, null: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 250
    t.string "preferences", limit: 2000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sygiops_support_groups", force: :cascade do |t|
    t.integer "signature_id"
    t.integer "email_address_id"
    t.string "name", limit: 160, null: false
    t.integer "assignment_timeout"
    t.string "follow_up_possible", limit: 100, default: "yes", null: false
    t.boolean "follow_up_assignment", default: true, null: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 250
    t.boolean "default_create", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sygiops_support_import_jobs", force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.boolean "dry_run", default: false
    t.text "payload"
    t.text "result"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sygiops_support_notifications", force: :cascade do |t|
    t.string "subject", limit: 250, null: false
    t.string "body", limit: 8000, null: false
    t.string "content_type", limit: 250, null: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 250
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_organizations", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.boolean "shared", default: true, null: false
    t.string "domain", limit: 250, default: ""
    t.boolean "domain_assignment", default: false, null: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 5000, default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timezone_name"
    t.integer "sla_id"
  end

  create_table "sygiops_support_overviews", force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "link", limit: 250, null: false
    t.integer "prio", null: false
    t.text "condition", null: false
    t.string "order", limit: 2500, null: false
    t.string "group_by", limit: 250
    t.string "group_direction", limit: 250
    t.boolean "organization_shared", default: false, null: false
    t.boolean "out_of_office", default: false, null: false
    t.string "view", limit: 1000, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_overviews_groups", id: false, force: :cascade do |t|
    t.integer "overview_id"
    t.integer "group_id"
  end

  create_table "sygiops_support_overviews_roles", id: false, force: :cascade do |t|
    t.integer "overview_id"
    t.integer "role_id"
  end

  create_table "sygiops_support_overviews_users", id: false, force: :cascade do |t|
    t.integer "overview_id"
    t.integer "user_id"
  end

  create_table "sygiops_support_roles", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "preferences"
    t.boolean "default_create", default: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 250
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_schedulers", force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "method", limit: 250, null: false
    t.integer "period"
    t.integer "running", default: 0, null: false
    t.datetime "last_run", precision: 3
    t.integer "prio", null: false
    t.string "pid", limit: 250
    t.string "note", limit: 250
    t.string "error_message"
    t.string "status"
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sygiops_support_settings", force: :cascade do |t|
    t.string "title", limit: 200, null: false
    t.string "name", limit: 200, null: false
    t.string "area", limit: 100, null: false
    t.string "description", limit: 2000, null: false
    t.string "options", limit: 2000
    t.boolean "state"
    t.text "state_current"
    t.string "state_initial", limit: 2000
    t.boolean "frontend", null: false
    t.text "preferences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sygiops_support_signatures", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "body"
    t.boolean "active", default: true, null: false
    t.string "note", limit: 250
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sygiops_support_slas", force: :cascade do |t|
    t.integer "calendar_id", null: false
    t.string "name", limit: 150
    t.integer "first_response_time"
    t.integer "update_time"
    t.integer "solution_time"
    t.text "condition"
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.boolean "default_create", default: false
  end

  create_table "sygiops_support_store_files", force: :cascade do |t|
    t.string "sha", limit: 128, null: false
    t.string "provider", limit: 20
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_store_objects", force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "note", limit: 250
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_store_provider_dbs", force: :cascade do |t|
    t.string "sha", limit: 128, null: false
    t.binary "data"
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_stores", force: :cascade do |t|
    t.integer "store_object_id", null: false
    t.integer "store_file_id", null: false
    t.bigint "o_id", null: false
    t.string "preferences", limit: 2500
    t.string "size", limit: 50
    t.string "filename", limit: 250, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_ticket_article_flags", force: :cascade do |t|
    t.integer "ticket_article_id", null: false
    t.string "key", limit: 50, null: false
    t.string "value", limit: 50
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_ticket_article_senders", force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "note", limit: 250
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_ticket_article_types", force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "note", limit: 250
    t.boolean "communication", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_ticket_articles", force: :cascade do |t|
    t.integer "ticket_id", null: false
    t.integer "type_id", null: false
    t.integer "sender_id", null: false
    t.string "from", limit: 3000
    t.string "to", limit: 3000
    t.string "cc", limit: 3000
    t.string "subject", limit: 3000
    t.string "reply_to", limit: 300
    t.string "message_id", limit: 3000
    t.string "message_id_md5", limit: 32
    t.string "in_reply_to", limit: 3000
    t.string "content_type", limit: 20, default: "text/plain", null: false
    t.string "references", limit: 3200
    t.text "body", null: false
    t.boolean "internal", default: false, null: false
    t.text "preferences"
    t.integer "origin_by_id"
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_ticket_counters", force: :cascade do |t|
    t.string "content", limit: 100, null: false
    t.string "generator", limit: 100, null: false
  end

  create_table "sygiops_support_ticket_flags", force: :cascade do |t|
    t.integer "ticket_id", null: false
    t.string "key", limit: 50, null: false
    t.string "value", limit: 50
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_ticket_priorities", force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.boolean "default_create", default: false, null: false
    t.string "ui_icon", limit: 100
    t.string "ui_color", limit: 100
    t.string "note", limit: 250
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_ticket_states", force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.integer "next_state_id"
    t.boolean "ignore_escalation", default: false, null: false
    t.boolean "default_create", default: false, null: false
    t.boolean "default_follow_up", default: false, null: false
    t.string "note", limit: 250
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_ticket_time_accountings", force: :cascade do |t|
    t.integer "ticket_id", null: false
    t.integer "ticket_article_id"
    t.decimal "time_unit", precision: 6, scale: 2, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "sygiops_support_ticket_types", force: :cascade do |t|
    t.string "name"
    t.string "note"
    t.boolean "default_create", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sygiops_support_tickets", force: :cascade do |t|
    t.integer "group_id"
    t.integer "priority_id"
    t.integer "state_id"
    t.integer "organization_id"
    t.string "number", limit: 60, null: false
    t.string "title", limit: 250, null: false
    t.integer "owner_id", null: false
    t.integer "customer_id", null: false
    t.string "note", limit: 250
    t.datetime "first_response_at", precision: 3
    t.datetime "first_response_escalation_at", precision: 3
    t.integer "first_response_in_min"
    t.integer "first_response_diff_in_min"
    t.datetime "close_at", precision: 3
    t.datetime "close_escalation_at", precision: 3
    t.integer "close_in_min"
    t.integer "close_diff_in_min"
    t.datetime "update_escalation_at", precision: 3
    t.integer "update_in_min"
    t.integer "update_diff_in_min"
    t.datetime "last_contact_at", precision: 3
    t.datetime "last_contact_agent_at", precision: 3
    t.datetime "last_contact_customer_at", precision: 3
    t.datetime "last_owner_update_at", precision: 3
    t.integer "create_article_type_id"
    t.integer "create_article_sender_id"
    t.integer "article_count"
    t.datetime "escalation_at", precision: 3
    t.datetime "pending_time", precision: 3
    t.integer "type_id"
    t.decimal "time_unit", precision: 6, scale: 2
    t.text "preferences"
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.boolean "response_warning", default: false
    t.boolean "resolution_warning", default: false
    t.boolean "response_breach", default: false
    t.boolean "resolution_breach", default: false
  end

  create_table "sygiops_support_users", force: :cascade do |t|
    t.string "login", limit: 255, null: false
    t.string "firstname", limit: 100, default: ""
    t.string "lastname", limit: 100, default: ""
    t.string "email", limit: 255, default: ""
    t.string "image", limit: 100
    t.string "image_source", limit: 200
    t.string "web", limit: 100, default: ""
    t.string "password", limit: 100
    t.string "phone", limit: 100, default: ""
    t.string "fax", limit: 100, default: ""
    t.string "mobile", limit: 100, default: ""
    t.string "department", limit: 200, default: ""
    t.string "street", limit: 120, default: ""
    t.string "zip", limit: 100, default: ""
    t.string "city", limit: 100, default: ""
    t.string "country", limit: 100, default: ""
    t.string "address", limit: 500, default: ""
    t.boolean "vip", default: false
    t.boolean "verified", default: false, null: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 5000, default: ""
    t.datetime "last_login", precision: 3
    t.string "source", limit: 200
    t.integer "login_failed", default: 0, null: false
    t.boolean "out_of_office", default: false, null: false
    t.date "out_of_office_start_at"
    t.date "out_of_office_end_at"
    t.integer "out_of_office_replacement_id"
    t.string "preferences", limit: 8000
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.integer "organization_id"
    t.integer "role_id", null: false
  end

  add_foreign_key "sygiops_support_groups", "sygiops_support_signatures", column: "signature_id"
  add_foreign_key "sygiops_support_organizations", "sygiops_support_slas", column: "sla_id"
  add_foreign_key "sygiops_support_overviews_groups", "sygiops_support_groups", column: "group_id"
  add_foreign_key "sygiops_support_overviews_groups", "sygiops_support_overviews", column: "overview_id"
  add_foreign_key "sygiops_support_overviews_roles", "sygiops_support_overviews", column: "overview_id"
  add_foreign_key "sygiops_support_overviews_roles", "sygiops_support_roles", column: "role_id"
  add_foreign_key "sygiops_support_overviews_users", "sygiops_support_overviews", column: "overview_id"
  add_foreign_key "sygiops_support_overviews_users", "sygiops_support_users", column: "user_id"
  add_foreign_key "sygiops_support_slas", "sygiops_support_calendars", column: "calendar_id"
  add_foreign_key "sygiops_support_stores", "sygiops_support_store_files", column: "store_file_id"
  add_foreign_key "sygiops_support_stores", "sygiops_support_store_objects", column: "store_object_id"
  add_foreign_key "sygiops_support_ticket_article_flags", "sygiops_support_ticket_articles", column: "ticket_article_id"
  add_foreign_key "sygiops_support_ticket_articles", "sygiops_support_ticket_article_senders", column: "sender_id"
  add_foreign_key "sygiops_support_ticket_articles", "sygiops_support_ticket_article_types", column: "type_id"
  add_foreign_key "sygiops_support_ticket_articles", "sygiops_support_tickets", column: "ticket_id"
  add_foreign_key "sygiops_support_ticket_articles", "sygiops_support_users", column: "origin_by_id"
  add_foreign_key "sygiops_support_ticket_flags", "sygiops_support_tickets", column: "ticket_id"
  add_foreign_key "sygiops_support_ticket_time_accountings", "sygiops_support_ticket_articles", column: "ticket_article_id"
  add_foreign_key "sygiops_support_ticket_time_accountings", "sygiops_support_tickets", column: "ticket_id"
  add_foreign_key "sygiops_support_tickets", "sygiops_support_groups", column: "group_id"
  add_foreign_key "sygiops_support_tickets", "sygiops_support_ticket_priorities", column: "priority_id"
  add_foreign_key "sygiops_support_tickets", "sygiops_support_ticket_states", column: "state_id"
  add_foreign_key "sygiops_support_tickets", "sygiops_support_ticket_types", column: "type_id"
  add_foreign_key "sygiops_support_tickets", "sygiops_support_users", column: "customer_id"
  add_foreign_key "sygiops_support_tickets", "sygiops_support_users", column: "owner_id"
  add_foreign_key "sygiops_support_users", "sygiops_support_organizations", column: "organization_id"
  add_foreign_key "sygiops_support_users", "sygiops_support_roles", column: "role_id"
end
