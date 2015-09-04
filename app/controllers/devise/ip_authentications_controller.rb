module Devise
  class IpAuthenticationsController < ::DeviseController
    prepend_before_filter :require_no_authentication, only: [:new]

    def new
      self.resource = resources_for_remote_ip
      return redirect_to new_session_path(resource_name) unless resource
      yield resource if block_given?
      respond_with(resource)
    end

    private

    def resources_for_remote_ip
      record = resource_class.ip_authenticable_klass.constantize.to_adapter.find_first(ip_address: request.remote_ip)
      record && record.owner
    end
  end
end
