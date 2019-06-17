# README

Most stable version of Ruby, Rails, Postgres must be downloaded. <br />
Postgres server must be running. <br />
To build clone down repo. <br />
Run `bundle` to install gems. <br />
Run `rake db:create && rake db:migrate`. <br />
Navigate to `lib/tasks/update_movies_in_theatres.rake` and replace line 8 `api_key = YOUR_OWN_API_KEY`.
To update movies in database run `rake db:update_movies_in_greek_theatres`. <br />
It will remove movies from the database if they're no longer in theatres as well as any director(s) associated with it. <br />


Database is setup in a way to easily associate cast as well as crew members to movies by using generic Person model like Movie db's API. <br />
To change country simply change `line 9` to the 2 letter ISO code for that country, `country = ISO_CODE` </br>

