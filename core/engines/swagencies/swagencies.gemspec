$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "swagencies/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "swagencies"
  s.version     = Swagencies::VERSION
  s.authors     = ["Ronaldo Possan"]
  s.email       = ["ronaldop@ciandt.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Swagencies."
  s.description = "TODO: Description of Swagencies."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "her"

  s.add_development_dependency "sqlite3"
end
