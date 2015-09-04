module ActionDispatch::Routing
  class Mapper
    protected

    # route for handle ip authentication
    def devise_ip_authentications(mapping, controllers)
      resource :ip_authentications, only: [:new], path: mapping.path_names[:ip_authentications],
                                    controller: controllers[:ip_authentications]
    end
  end
end

module IpAuth
  class Engine < ::Rails::Engine
  end
end
