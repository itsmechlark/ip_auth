require 'action_dispatch/testing/integration'
require_relative 'helpers/user_test_helper'

class ActionDispatch::IntegrationTest
  include UserTestHelper

  def warden
    request.env['warden']
  end

  def session_for_scope(scope)
    warden.request.session["warden.user.#{scope}.session"] || {}
  end

  def sign_in_as_user(options = {}, &_block)
    user = create_user(options)
    get_with_option options[:visit], new_user_session_path
    fill_in 'email', with: options[:email] || user.email
    fill_in 'password', with: options[:password] || '12345678'
    check 'remember me' if options[:remember_me] == true
    yield if block_given?
    click_button 'Log In'
    user
  end

  def sign_in_via_ip_as_user(options = {}, &_block)
    user = create_user(options)
    user.ip_authenticables.create!(ip_address: options[:ip_address] || '127.0.0.1')
    get_with_option options[:visit], new_user_ip_authentications_path
    fill_in 'g-recaptcha-response', with: options['g-recaptcha-response'] || Devise.friendly_token
    yield if block_given?
    click_button 'Log In'
    user
  end

  # Fix assert_redirect_to in integration sessions because they don't take into
  # account Middleware redirects.
  #
  def assert_redirected_to(url)
    assert [301, 302].include?(@integration_session.status),
           "Expected status to be 301 or 302, got #{@integration_session.status}"

    assert_url url, @integration_session.headers['Location']
  end

  def assert_current_url(expected)
    assert_url expected, current_url
  end

  def assert_url(expected, actual)
    assert_equal prepend_host(expected), prepend_host(actual)
  end

  protected

  def get_with_option(given, default)
    case given
    when String
      get given
    when FalseClass
    # Do nothing
    else
      get default
    end
  end

  def prepend_host(url)
    url = "http://#{request.host}#{url}" if url[0] == '/'
    url
  end
end
