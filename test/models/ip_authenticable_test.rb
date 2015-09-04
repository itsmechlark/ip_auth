require 'test_helper'
require "orm/#{DEVISE_ORM}/ip_authenticable"

class IpAuthTest < ActiveSupport::TestCase
  include IpAuthenticableTestHelper
  include UserTestHelper

  test 'required_fields should contain the fields that Devise uses' do
    assert_same_content Devise::Models::IpAuthenticable.required_fields(User), [:ip_authenticable_klass]
  end

  test 'should respond to ip_authenticables' do
    user = new_user
    assert user.respond_to?(:ip_authenticables)
  end
end
