# README

Most stable version of Ruby, Rails, Postgres must be downloaded. <br />
Postgres server must be running. <br />
To build clone down repo. <br />
Run `bundle` to install gems. <br />
Run `rake db:create && rake db:migrate`. <br />
To update movies in database run `rake db:update_movies_in_greek_theatres`. <br />
It will remove movies from the database if they're no longer in theatres as well as any director(s) associated with it. <br />
