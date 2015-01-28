class User < ActiveRecord::Base
  devise :omniauthable, omniauth_providers: [:github]

  has_one :authorization
end
