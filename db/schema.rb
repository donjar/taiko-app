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

ActiveRecord::Schema.define(version: 2021_05_28_045843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "charts", force: :cascade do |t|
    t.integer "song_id", null: false
    t.string "level", null: false
    t.integer "stars"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["song_id", "level"], name: "index_charts_on_song_id_and_level", unique: true
    t.index ["song_id"], name: "index_charts_on_song_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "score", null: false
    t.integer "ryo", null: false
    t.integer "ka", null: false
    t.integer "fuka", null: false
    t.integer "rolls", null: false
    t.integer "chart_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "crown"
    t.string "best_score"
    t.index ["chart_id"], name: "index_scores_on_chart_id", unique: true
  end

  create_table "song_categories", force: :cascade do |t|
    t.bigint "song_id", null: false
    t.integer "sequence_no", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_song_categories_on_category_id"
    t.index ["song_id"], name: "index_song_categories_on_song_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "name", null: false
    t.integer "donder_hiroba_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "bpm"
    t.index ["donder_hiroba_id"], name: "index_songs_on_donder_hiroba_id", unique: true
  end

  add_foreign_key "charts", "songs"
  add_foreign_key "scores", "charts"
  add_foreign_key "song_categories", "categories"
  add_foreign_key "song_categories", "songs"
end
