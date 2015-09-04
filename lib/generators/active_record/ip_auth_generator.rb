require 'rails/generators/active_record'
require 'generators/ip_auth/orm_helpers'

module ActiveRecord
  module Generators
    class IpAuthGenerator < ActiveRecord::Generators::Base
      argument :attributes, type: :array, default: [], banner: 'field:type field:type'

      include IpAuth::Generators::OrmHelpers
      source_root File.expand_path('../templates', __FILE__)

      def copy_ip_auth_migration
        migration_template 'migration.rb', 'db/migrate/ip_auth_create_devise_ip_authenticables.rb' unless ip_authenticable_exist?
      end

      def inject_ip_auth_content
        content = model_contents

        class_path = if namespaced?
                       class_name.to_s.split('::')
                     else
                       [class_name]
                     end

        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| '  ' * indent_depth + line } .join("\n") << "\n"
        inject_into_class(model_path, class_path.last, content) if model_exists?
      end
    end
  end
end
