module SharedUser
  extend ActiveSupport::Concern

  included do
    devise :database_authenticatable, :ip_authenticable, :registerable
  end
end
