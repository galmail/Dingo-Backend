# Dingo Backend #

It runs on Heroku at: http://dingoapp.herokuapp.com

Check the APIs at: http://dingoapp.herokuapp.com/api

Admin Web App is running at: http://dingoapp.herokuapp.com/admin

## Tech Stack and Dependencies ##

* [Heroku](http://heroku.com) Cedar Stack
* [Ruby on Rails](http://rubyonrails.org)
* [PostgreSQL](http://www.postgresql.org)
* [Amazon S3](http://aws.amazon.com/console/)
* [Apigee](http://apigee.com) Console
* [ActiveAdmin](http://activeadmin.info)

## ActiveAdmin ##

To manage a new model do: rails generate active_admin:resource <Model>

## Annotate ##

To comment model attributes do: annotate --exclude tests,fixtures,factories

## Setting Environment Variables ##

set them in config/application.yml
rake figaro:heroku
