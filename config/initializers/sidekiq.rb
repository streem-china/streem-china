config = { url: 'redis://localhost:6379/2', namespace: 'streem-china' }

Sidekiq.configure_server { |config| config.redis = config }

Sidekiq.configure_client { |config| config.redis = config }
