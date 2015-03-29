module ActiveRecord
  class Base
    class << self
      adapter = ActiveRecord::Base.connection.adapter_name

      random_fun = adapter.eql?('Mysql2') ? 'rand()' : 'random()'

      define_method :random, -> { order(random_fun) }
    end
  end
end
