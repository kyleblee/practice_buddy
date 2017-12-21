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

ActiveRecord::Schema.define(version: 20171221022730) do

  create_table "artist_genres", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artist_users", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "backing_track_licks", force: :cascade do |t|
    t.integer "backing_track_id"
    t.integer "lick_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "backing_track_tonalities", force: :cascade do |t|
    t.integer "backing_track_id"
    t.integer "tonality_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "backing_track_users", force: :cascade do |t|
    t.integer "backing_track_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "backing_tracks", force: :cascade do |t|
    t.string "name"
    t.integer "bpm"
    t.datetime "last_practiced"
    t.string "key"
    t.text "description"
    t.string "link"
    t.integer "artist_id"
    t.integer "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genre_licks", force: :cascade do |t|
    t.integer "genre_id"
    t.integer "lick_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lick_tonalities", force: :cascade do |t|
    t.integer "lick_id"
    t.integer "tonality_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "licks", force: :cascade do |t|
    t.string "name"
    t.integer "bpm"
    t.datetime "last_practiced"
    t.datetime "scheduled_practice"
    t.string "current_key"
    t.text "description"
    t.string "link"
    t.integer "performance_rating"
    t.integer "artist_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tonalities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tunes", force: :cascade do |t|
    t.string "name"
    t.datetime "last_practiced"
    t.datetime "scheduled_practice"
    t.string "key"
    t.string "link"
    t.text "description"
    t.integer "performance_rating"
    t.integer "user_id"
    t.integer "artist_id"
    t.integer "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "uid"
    t.string "image"
    t.text "description"
    t.boolean "admin", default: false
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
