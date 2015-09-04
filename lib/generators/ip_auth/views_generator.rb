require 'rails/generators/base'
require 'generators/devise/views_generator'

module IpAuth
  module Generators
    # Include this module in your generator to generate IP views.
    # `copy_views` is the main method and by default copies all views
    # with forms.
    # Based on https://github.com/plataformatec/devise
    module ViewPathTemplates #:nodoc:
      extend ActiveSupport::Concern
      include ::Devise::Generators::ViewPathTemplates

      def copy_views
        if options[:views]
          options[:views].each do |directory|
            view_directory directory.to_sym
          end
        else
          view_directory :ip_authentications
        end
      end

      protected

      def view_directory(name, path = nil)
        directory name.to_s, path || "#{target_path}/#{name}" do |content|
          content
        end
      end
    end

    #:nodoc:
    class FormForGenerator < Rails::Generators::Base
      include ViewPathTemplates
      source_root File.expand_path('../../../../app/views/devise', __FILE__)
      desc 'Copies default Devise views to your application.'
      hide!
    end

    class SimpleFormForGenerator < Rails::Generators::Base #:nodoc:
      include ViewPathTemplates
      source_root File.expand_path('../../templates/simple_form_for', __FILE__)
      desc 'Copies simple form enabled views to your application.'
      hide!
    end

    #:nodoc:
    class ViewsGenerator < Rails::Generators::Base
      desc 'Copies IP Auth views to your application.'

      argument :scope, required: false, default: nil,
                       desc: 'The scope to copy views to'

      hook_for :form_builder, aliases: '-b',
                              desc: 'Form builder to be used',
                              default: defined?(SimpleForm) ? 'simple_form_for' : 'form_for'
    end
  end
end
