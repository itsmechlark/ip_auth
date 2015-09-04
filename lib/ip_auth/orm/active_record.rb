require 'orm_adapter/adapters/active_record'

module IpAuth
  class IpAuthenticable < ActiveRecord::Base
    self.table_name = 'devise_ip_authenticables'

    belongs_to :owner, polymorphic: true
  end
end
