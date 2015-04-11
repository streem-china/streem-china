db = Rails.env.test? ? 1 : 0

Redis.current = Redis.new(host: 'localhost', port: 6379, db: db)
