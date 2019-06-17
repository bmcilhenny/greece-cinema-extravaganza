# README

## Most stable version of Ruby, Rails, Postgres must be downloaded. <br />
Postgres server must be running. <br />
</br>

## How to build
clone down repo. <br />
Run `bundle` to install gems. <br />
Run `rake db:create && rake db:migrate` to create postgres database and setup schema. <br />
Navigate to `lib/tasks/update_movies_in_theatres.rake` and replace line 8 `api_key = YOUR_OWN_API_KEY` with your own API key </br>
</br>
To update movies in database run `rake db:update_movies_in_greek_theatres`. <br />
*It will remove movies from the database if they're no longer in theatres as well as any director(s) associated with it.* <br />
</br>

Database is setup in a way to easily associate cast as well as crew members to movies by using generic Person model like Movie db's API. <br />
<br />
To change country simply change `line 9` to the 2 letter ISO code for that country, `country = ISO_CODE` </br>


## DDL

create_table "movies", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "original_title"
    t.string "movie_db_id"
    t.string "poster"
    t.boolean "in_theatres"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

create_table "crews", force: :cascade do |t|
    t.integer "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "imdb_url"
    t.integer "person_db_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "person_crews", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "crew_id", null: false
    t.string "department"
    t.string "job"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
