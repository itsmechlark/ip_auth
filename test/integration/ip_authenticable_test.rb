require 'test_helper'
require 'ip_authenticable_test_helper'

class IpAuthenticableTest < ActionDispatch::IntegrationTest
  include IpAuthenticableTestHelper

  def after_setup
    stubs_with_default_ip
  end

  test 'sign in without ip' do
    sign_in_as_user

    assert warden.authenticated?(:user)
  end

  test 'authenticate with ip' do
    sign_in_via_ip_as_user

    assert warden.authenticated?(:user)
  end

  test 'redirect to scope session path when cant authenticate remote ip' do
    stubs_with_new_ip
    get new_user_ip_authentications_path
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'sign out when ip change and invalid' do
    sign_in_via_ip_as_user

    stubs_with_new_ip

    get root_path
    assert_not warden.authenticated?(:user)
  end

  test 'ip authentication tag should be remove at sign out' do
    sign_in_via_ip_as_user

    get destroy_user_session_path

    assert_nil session_for_scope(:user)['ip_authentication']
  end
end
