module ActiveRecord
  class Base
    class << self
      adapter = ActiveRecord::Base.connection.adapter_name

      random_fun = adapter.eql?('Mysql2') ? 'rand()' : 'random()'

      define_method :random do |count=1|
        order(random_fun).limit(count)
      end
    end
  end
end
