require 'devise/strategies/authenticatable'
require 'recaptcha'

module IpAuth
  module Strategies
    # Strategy for signing in a user, based on IP address in the database. It verifies user
    # request using reCAPTCHA.
    class IpAuthenticable < ::Devise::Strategies::Authenticatable
      include Recaptcha::Verify

      def valid?
        params['g-recaptcha-response'].present? && super
      end

      def authenticate!
        resource  = remote_ip.present? && mapping.to.find_for_ip_authentication(authentication_hash, remote_ip)
        if validate(resource)
          resource.after_ip_authentication
          success!(resource) && session['ip_authentication'] = true
        end
        fail(:not_found_in_database) unless resource
      end

      private

      # Receives a resource and check if it is valid by calling valid_for_authentication?
      # An optional block that will be triggered while validating can be optionally
      # given as parameter. Check IpAuth::Models::IpAuthenticable.valid_for_authentication?
      # for more information.
      #
      # In case the resource can't be validated, it will fail with the given
      # unauthenticated_message.
      def validate(resource)
        result = resource && verify_recaptcha

        if result
          true
        else
          fail!(resource.ip_unauthenticated_message) if resource
          false
        end
      end

      # Extract a hash with attributes:values from the http params.
      def http_auth_hash
        keys = [http_authentication_key, :ip_address]
        Hash[*keys.zip(decode_credentials).flatten]
      end

      # Extract the appropriate subhash for authentication from params.
      def params_auth_hash
        params[scope].merge ip_address: remote_ip
      end

      def remote_ip
        request.remote_ip
      end

      # Provides a scoped session data for authenticated users.
      # Warden manages clearing out this data when a user logs out
      def session
        raw_session["warden.user.#{scope}.session"] ||= {}
      end
    end
  end
end

Warden::Strategies.add(:ip_authenticable, IpAuth::Strategies::IpAuthenticable)
