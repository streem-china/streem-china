sidekiq_config = { url: 'redis://localhost:6379/2',
                   namespace: 'streem-china:sidekiq' }

Sidekiq.configure_server { |config| config.redis = sidekiq_config }
Sidekiq.configure_client { |config| config.redis = sidekiq_config }
