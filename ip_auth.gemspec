lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ip_auth/version'

Gem::Specification.new do |s|
  s.name          = 'ip_auth'
  s.version       = IpAuth::VERSION.dup
  s.platform      = Gem::Platform::RUBY
  s.licenses      = ['MIT']
  s.authors       = ['John Chlark Sumatra']
  s.email         = ['jcsumatra@cdasia.com']
  s.homepage      = 'https://github.com/itsmechlark/ip_auth'

  s.summary       = 'IP Authentication for devise'
  s.description   = 'IP Authentication for devise'

  s.files         = `git ls-files`.split("\n") - %w(.gitignore .travis.yml .coveralls.yml)
  s.test_files    = s.files.grep(/^test/)
  s.require_paths = ['lib']
  s.extra_rdoc_files      = %w(LICENSE.txt README.md)

  s.add_dependency('devise', '>= 2.0.0')
  s.add_dependency('recaptcha')
end
