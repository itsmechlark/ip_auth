require 'generators/devise/orm_helpers'

module IpAuth
  module Generators
    module OrmHelpers
      include Devise::Generators::OrmHelpers

      def model_contents
        <<-CONTENT
  devise :ip_authenticable
        CONTENT
      end

      def ip_authenticable_exist?
        Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+ip_auth_create_devise_ip_authenticables.rb$/).first
      end
    end
  end
end
