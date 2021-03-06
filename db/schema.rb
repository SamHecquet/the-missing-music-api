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

ActiveRecord::Schema.define(version: 20170430181652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "artists", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "slug",       null: false
    t.string   "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_artists_on_name", using: :btree
  end

  create_table "festivals", force: :cascade do |t|
    t.string   "name",                null: false
    t.string   "slug",                null: false
    t.string   "url"
    t.integer  "year"
    t.string   "location"
    t.string   "date"
    t.string   "ticket"
    t.boolean  "camping"
    t.string   "website"
    t.string   "spotify_playlist_id"
    t.string   "spotify_user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "short_name"
    t.index ["name", "year"], name: "index_festivals_on_name_and_year", unique: true, using: :btree
    t.index ["name"], name: "index_festivals_on_name", using: :btree
    t.index ["short_name"], name: "index_festivals_on_short_name", using: :btree
  end

  create_table "festivals_artists", force: :cascade do |t|
    t.integer "festival_id"
    t.integer "artist_id"
    t.boolean "headliner",   default: false
    t.index ["artist_id"], name: "index_festivals_artists_on_artist_id", using: :btree
    t.index ["festival_id", "artist_id"], name: "index_festivals_artists_on_festival_id_and_artist_id", unique: true, using: :btree
    t.index ["festival_id"], name: "index_festivals_artists_on_festival_id", using: :btree
  end

end
