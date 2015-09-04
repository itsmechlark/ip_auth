require 'rails'
require 'active_support/core_ext/integer'
require 'active_support/ordered_hash'
require 'active_support/concern'
require 'orm_adapter'
require 'devise'

module Devise
  mattr_accessor :ip_authenticable_klass
  @@ip_authenticable_klass = 'IpAuth::IpAuthenticable'
end

# modules
Devise.add_module :ip_authenticable, model: 'ip_auth/models/ip_authenticable', strategy: true,
                                     controller: :ip_authentications, route: { ip_authentications: [:new] }

require 'ip_auth/rails'
