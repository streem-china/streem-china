## Streem China

[![Build Status](https://travis-ci.org/streem-china/streem-china.svg)](https://travis-ci.org/streem-china/streem-china)
[![Code Climate](https://codeclimate.com/github/streem-china/streem-china/badges/gpa.svg)](https://codeclimate.com/github/streem-china/streem-china)
[![Test Coverage](https://codeclimate.com/github/streem-china/streem-china/badges/coverage.svg)](https://codeclimate.com/github/streem-china/streem-china)

This is the source code of [Streem China](http://streem-china.org) website.

**Note**: Streem China is still in the development stage. Stay tuned.

### Dependencies

* Ruby

* Redis

* SQLite / MySQL / PostgreSQL

### External Service

* Github OAuth

* Twitter OAuth

* New Relic

* Qiniu

* Mailgun

### Usage

```ruby
cp config/database.sqlite.yml config/database.yml
cp config/secrets.example.yml config/secrets.yml
cp config/newrelic.example.yml config/newrelic.yml
bundle exec rake db:setup
bundle exec sidekiq -C config/sidekiq.yml
bundle exec puma -p 28080 cable/config.ru
bundle exec rails s
```

### Testing

```ruby
bundle exec rake test
```

## License

MIT license (© 2015 Streem China)
