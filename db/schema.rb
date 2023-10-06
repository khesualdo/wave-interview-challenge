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

ActiveRecord::Schema[7.0].define(version: 2023_10_06_042014) do
  create_table "time_report_details", force: :cascade do |t|
    t.integer "time_report_id", null: false
    t.datetime "date"
    t.float "hours_worked"
    t.string "employee_id"
    t.string "job_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["time_report_id"], name: "index_time_report_details_on_time_report_id"
  end

  create_table "time_reports", force: :cascade do |t|
    t.integer "time_report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["time_report_id"], name: "index_time_reports_on_time_report_id", unique: true
  end

  add_foreign_key "time_report_details", "time_reports"
end
