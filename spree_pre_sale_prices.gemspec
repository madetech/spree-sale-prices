# encoding: UTF-8
$:.push File.expand_path('./lib', File.dirname(__FILE__))
require 'spree_pre_sale_prices/version'

Gem::Specification.new do |s|
  s.name        = 'spree_pre_sale_prices'
  s.version     = PreSalePrices::VERSION
  s.summary     = 'Add suport for sale prices to Spree'
  s.description = s.summary
  s.license     = 'BSD-3-Clause'

  s.author    = 'Chris Blackburn'
  s.email     = 'chris@madetech.com'
  s.homepage  = 'https://www.madetech.com'

  s.extra_rdoc_files = %w{LICENSE README.md}
  s.rdoc_options = %w{--charset=UTF-8}

  s.files = Dir['{app,lib,spec}/**/*.rb'] + s.extra_rdoc_files
  s.test_files    = %w{spec}
  s.require_paths = %w{lib app}

  s.add_dependency 'spree', '~> 2.0'
  s.add_dependency 'spree_multi_currency'
  s.add_dependency 'money', '6.0.1'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'rb-readline'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
end
