# Keymail Example [![Build Status](https://travis-ci.org/alcesleo/keymail-example.svg?branch=master)](https://travis-ci.org/alcesleo/keymail-example)

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

### Setup mailing

The `config/initializers/setup_mail.rb` relies on [Figaro](https://github.com/laserlemon/figaro) for
the email credentials, you can set it up by creating a `config/application.yml` file with this content:

```yaml
EMAIL_USERNAME: "your_gmail_username"
EMAIL_PASSWORD: "your_gmail_password"
```

To use something other than Gmail you need to change the settings in `config/initializers/setup_mail.rb` manually.

### Dummy data

The seeds file generates a bunch of crap to play with:

    rake db:seed

## Testing

```bash
# run the tests
rake test
```

Here's a useful [cheat sheet](http://cheat.errtheblog.com/s/minitest) of the matchers you can use.

## Deploying

```bash
# first time you need to create the app
heroku create keymail-example --addons heroku-postgresql # http://keymail-example.herokuapp.com/

# upload the app
git push heroku master

# run the migrations
heroku run rake db:migrate

# update your credentials from application.yml
rake figaro:heroku[keymail-example]
```

Note: GMail may block Heroku from accessing your account, even if it is with
the correct credentials, (raising a `Net::SMTPAuthenticationError`). To fix
this problem you need to log in to the GMail account and then visit
<http://www.google.com/accounts/DisplayUnlockCaptcha> to open the account up
for new devices.

