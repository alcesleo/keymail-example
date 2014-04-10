# Keymail Example [![Build Status](https://travis-ci.org/alcesleo/keymail-example.svg?branch=dev)](https://travis-ci.org/alcesleo/keymail-example)

**This is an [example application](http://keymail-example.herokuapp.com/) built with [keymail](https://github.com/alcesleo/keymail).**

It is a simple message board with _login via email_ functionality, it is heavily
influensed by <https://nomorepasswordsjustemail.meteor.com/> but using Rails.

## Developing

### Setup Postgres

There is an excellent
[railscast](http://railscasts.com/episodes/342-migrating-to-postgresql?view=asciicast)
on migrating to Postgres that should cover everything you need to know, but the
steps are provided here as well.

```bash
# install postgres
brew install postgresql

# initialize the database cluster
initdb /usr/local/var/postgres

# start the database server
pg_ctl start -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log

# create the postgres user
createuser -s -r postgres

# let rails create the databases
rake db:create:all

# and apply the migrations
rake db:migrate
```

If you restart your computer or turn off the database server for some reason, this
is the command you need to run again to **start the postgres server:**

    pg_ctl start -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log

### Dummy data

The seeds file generates a bunch of crap to play with:

    rake db:seed

- setup figaro

## Testing

```bash
# run the tests
rake test
```

Here's a useful [cheat sheet](http://cheat.errtheblog.com/s/minitest) of the matchers you can use.


## Deploying

```bash
# first time you need to create the app
# this will live at name_of_my_app.herokuapp.com
heroku create name_of_my_app --addons heroku-postgresql

# upload the app and run the migrations
git push heroku master
heroku run rake db:migrate
```

