# README

## Most stable version of Ruby, Rails, Postgres must be downloaded. <br />
Postgres server must be running! <br />
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

```
CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title STRING,
    description TEXT,
    original_tite STRING,
    movide_db_id INTEGER,
    poster STRING
)

CREATE TABLE crews (
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (movie_id) REFERENCES movies (id)
)

CREATE TABLE persons (
    id SERIAL PRIMARY KEY,
    name STRING,
    imdb_url STRING,
    person_db_id INTEGER
)

CREATE TABLE person_crews (
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (person_id) REFERENCES persons (id),
    FOREIGN KEY (crew_id) REFERENCES crews (id),
    department STRING,
    job STRING   
)
```
