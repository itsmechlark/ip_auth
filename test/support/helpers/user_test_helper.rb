require_relative 'base_test_helper'

module UserTestHelper
  include BaseTestHelper

  def valid_attributes(attributes = {})
    { username: 'usertest',
      email: generate_unique_email,
      password: '12345678',
      password_confirmation: '12345678',
      created_at: Time.now.utc
    }.update(attributes)
  end

  def new_user(attributes = {})
    User.new(valid_attributes(attributes))
  end

  def create_user(attributes = {})
    @user ||= begin
      User.create!(valid_attributes(attributes))
    end
  end

  def current_user(attributes = {})
    @@current_user ||= create_user(attributes)
  end
end
