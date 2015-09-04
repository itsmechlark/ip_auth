require_relative 'base_test_helper'

module IpAuthenticableTestHelper
  include BaseTestHelper

  def stubs_with_default_ip
    stubs_with_ip(default_options[:ip_address])
  end

  def stubs_with_ip(ip = nil)
    ip ||= generate_ip_address
    ActionDispatch::Request.any_instance.stubs(:remote_ip).returns(ip)
  end
  alias_method :stubs_with_new_ip, :stubs_with_ip

  def default_options
    { ip_address: '127.0.0.1' }
  end
end
