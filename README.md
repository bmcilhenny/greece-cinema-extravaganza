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

Database is setup in a way to easily associate cast as well as crew members to a movie by using generic Person model like Movie db's API. This way a person can be associated with a crew, and in the future, a cast of that same movie. An example: Quentin Tarintino directed as well as starred in Reservoir Dogs, for instance. You'd create one Person for Quentin, then a corresponding person_crews row as well as a person_casts row for his corresponding directing as a crew member as well as a cast member for his acting role. <br />

<br />
A movie has one crew, a crew has many person_crews, a crew has many persons through person_crews. A person has many person_crews, a person has many crews through person_crews.

<br />
<br />
To change country simply change `line 9` to the 2 letter ISO code for that country, `country = ISO_CODE` </br>


## DDL

```
CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title STRING,
    description TEXT,
    original_tite STRING,
    movide_db_id STRING UNIQUE,
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
    person_db_id INTEGER UNIQUE
)

CREATE TABLE person_crews (
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (person_id) REFERENCES persons (id),
    FOREIGN KEY (crew_id) REFERENCES crews (id),
    department STRING,
    job STRING   
)
```

# How to get a list of a Movie's directors

1. use command `rails console`
2. Query for a movie, e.g. `Movie.last`.
3. Use .get_crew('director', 'directing') instance method. This will grab all associated persons with that movie who have the job name 'Director' and are a part of the 'directing department. Wrote this for more flexibility when database has more than just crew members who are directors. Can use this to get script writers from script department, lighting etc.
4. Or, simply use .directors to grab people with the job of 'director' and the department of 'directing'.

![Image of a movie's directors](https://i.ibb.co/GJngXs7/Screen-Shot-2019-06-17-at-2-48-49-PM.png)
