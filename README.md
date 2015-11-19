# shoppingapp

## Setup
Install bundler and run `bundle install`

## Database

Configure `config/database.yml`. Fill in username/password (if any):

```yaml
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  host: localhost
  username:
  password:

development: &development
  <<: *default
  database: demoshopping_development

test:
  <<: *default
  database: demoshopping_test

production: *development
```

Run `rake db:create db:migrate`.
