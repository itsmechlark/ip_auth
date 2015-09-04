class CustomIpAuthenticable < ActiveRecord::Base
  self.table_name = 'devise_ip_authenticables'

  belongs_to :owner, polymorphic: true
end
