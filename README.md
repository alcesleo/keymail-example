# Keymail Example [![Build Status](https://travis-ci.org/alcesleo/keymail-example.svg?branch=dev)](https://travis-ci.org/alcesleo/keymail-example)

**This is an example application built with [keymail](https://github.com/alcesleo/keymail).**

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

- setup figaro

## Testing

    rake test

## Deploying

TODO

