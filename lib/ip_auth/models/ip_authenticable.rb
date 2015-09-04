require 'ip_auth/hooks/ip_authenticable'
require 'ip_auth/strategies/ip_authenticable'

module Devise
  module Models
    module IpAuthenticable
      extend ActiveSupport::Concern

      included do
        has_many :ip_authenticables, as: :owner, class_name: ip_authenticable_klass.constantize,
                                     dependent: :destroy
      end

      def self.required_fields(_klass)
        [:ip_authenticable_klass]
      end

      def ip_unauthenticated_message
        :invalid
      end

      def active_for_ip_authentication?
        true
      end

      def valid_for_ip_authentication?(ip_address)
        ip_authenticables.where(ip_address: ip_address).present?
      end

      # A callback initiated after successfully authenticating. This can be
      # used to insert your own logic that is only run after the user successfully
      # authenticates.
      #
      # Example:
      #
      #   def after_ip_authentication
      #     self.update_attribute(:invite_code, nil)
      #   end
      #
      def after_ip_authentication
      end

      module ClassMethods
        ::Devise::Models.config self, :ip_authenticable_klass

        def find_for_ip_authentication(conditions, ip_address)
          resource = to_adapter.find_first(conditions)
          opts = { owner: resource, ip_address: ip_address }
          record = resource && ip_authenticable_klass.constantize.to_adapter.find_first(opts)
          record && record.owner
        end
      end
    end
  end
end
