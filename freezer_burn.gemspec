#gem 'docopt', '~> 0.5.0'
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
name = "freezer_burn"
require "#{name}/version"


Gem::Specification.new do |gem|
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["shadowbq"]
  gem.email         = ["shadowbq@gmail.com"]
  gem.description   = %q{rough management of compressed gems}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/shadowbq/freezer_burn"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "freezer_burn"
  gem.require_paths = ["lib"]
  gem.version       = FreezerBurn::VERSION
  gem.license       = 'MIT'

  #Gonna is a mechanize example bin that fetches are parses a fake page.
  gem.add_dependency('docopt', '~> 0.5.0')

  # gem.add_development_dependency('pry')
  gem.add_development_dependency('bump')
  gem.add_development_dependency('minitest-colorize')
  gem.add_development_dependency('ansi')
  gem.add_development_dependency('simplecov')
  gem.add_development_dependency('travis')
  gem.add_development_dependency('codeclimate-test-reporter')
end
