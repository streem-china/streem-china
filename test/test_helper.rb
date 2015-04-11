ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end

require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start
