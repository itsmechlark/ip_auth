require 'test_helper'

class ViewsGeneratorTest < Rails::Generators::TestCase
  tests IpAuth::Generators::ViewsGenerator
  destination File.expand_path('../../tmp', __FILE__)
  setup :prepare_destination

  test 'Assert all views are properly created with no params' do
    run_generator
    assert_files
  end

  test 'Assert all views are properly created with scope param' do
    run_generator %w(users)
    assert_files 'users'
  end

  test 'Assert views with simple form' do
    run_generator %w(-b simple_form_for)
    assert_file 'app/views/devise/ip_authentications/new.html.erb', /simple_form_for/

    run_generator %w(users -b simple_form_for)
    assert_file 'app/views/users/ip_authentications/new.html.erb', /simple_form_for/
  end

  def assert_files(scope = nil)
    scope = 'devise' if scope.nil?

    assert_file "app/views/#{scope}/ip_authentications/new.html.erb"
  end
end
