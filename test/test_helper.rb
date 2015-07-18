ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  before { Redis.current.flushdb }
end

require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start

require 'mocha/mini_test'
