Gem::Specification.new do |gem|
  gem.name    = 'sports_direct'
  gem.version = '0.0.2'
  gem.summary = 'An interface library for the Sports Direct web service.'
  gem.homepage = %q{http://github.com/tylerhunt/sports_direct}
  gem.authors = ['Tyler Hunt']

  gem.files = Dir['lib/**/*']
  gem.add_dependency 'activesupport', '3.0.3'
  gem.add_dependency 'httparty', '0.6.1'
  gem.add_dependency 'i18n', '0.5.0'
  gem.add_dependency 'nokogiri', '1.4.4'
  gem.add_dependency 'tzinfo', '0.3.23'
  gem.add_development_dependency 'rspec', '2.3.0'
  gem.add_development_dependency 'vcr', '1.4.0'
  gem.add_development_dependency 'webmock', '1.6.1'
end
