require 'rails/generators/named_base'

module IpAuth
  module Generators
    class IpAuthGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      namespace 'ip_auth'

      hook_for :orm
    end
  end
end
