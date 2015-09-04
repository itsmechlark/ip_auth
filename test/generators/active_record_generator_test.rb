require 'test_helper'

if DEVISE_ORM == :active_record
  require 'generators/active_record/ip_auth_generator'

  class ActiveRecordGeneratorTest < Rails::Generators::TestCase
    tests ActiveRecord::Generators::IpAuthGenerator

    destination File.expand_path('../../tmp', __FILE__)
    setup :prepare_destination

    test 'add migration for devise_ip_authenticables' do
      run_generator %w(user)
      assert_migration 'db/migrate/ip_auth_create_devise_ip_authenticables.rb'
    end

    test 'all files are properly deleted' do
      run_generator %w(monster)
      assert_migration 'db/migrate/ip_auth_create_devise_ip_authenticables.rb'
      run_generator %w(monster), behavior: :revoke
      assert_no_migration 'db/migrate/ip_auth_create_devise_ip_authenticables.rb'
    end
  end
end
