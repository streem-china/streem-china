## Streem China

[![Build Status](https://travis-ci.org/streem-china/streem-china.svg)](https://travis-ci.org/streem-china/streem-china)
[![Code Climate](https://codeclimate.com/github/streem-china/streem-china/badges/gpa.svg)](https://codeclimate.com/github/streem-china/streem-china)

This is the source code of [Streem China](http://streem-china.org) website.

**Note**: Streem China is still in the development stage. Stay tuned.

### Dependencies

* Ruby

* Redis

* SQLite / MySQL / PostgreSQL

### External Service

* Github(Oauth2)

* Qiniu

* Mailgun

### Usage

```ruby
cp config/database.sqlite.yml config/database.yml (Edit)
cp config/secrets.example.yml config/secrets.yml (Edit)
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rails s
```

### Testing

```ruby
bundle exec rake test
```

## License

MIT license (© 2015 Streem China)
