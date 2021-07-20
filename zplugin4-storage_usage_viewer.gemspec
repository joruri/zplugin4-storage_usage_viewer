$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "zplugin/storage_usage_viewer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "zplugin4-storage_usage_viewer"
  s.version     = Zplugin::StorageUsageViewer::VERSION
  s.authors     = ["SiteBridge Inc."]
  s.email       = ["info@sitebridge.co.jp"]
  s.homepage    = "https://github.com/joruri/zplugin4-storage_usage_viewer"
  s.summary     = "View site storage usage."
  s.description = "View site storage usage."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"
  s.add_dependency "pg"
  s.add_dependency "addressable"
  s.add_dependency "moji"
  s.add_dependency "marcel"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "simplecov"
end
