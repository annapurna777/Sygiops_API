$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "sygiops_support/version"
# require 'net/ldap'
# require 'resolv'
# require 'delayed_job'
# require 'mail'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "sygiops_support"
  spec.version     = SygiopsSupport::VERSION
  spec.authors     = ["annapurna777"]
  spec.email       = ["annapurna.tiwari@sygitech.com"]
  spec.homepage    = "https://www.sygitech.com"
  spec.summary     = "Summary of SygiopsSupport."
  spec.description = "Description of SygiopsSupport."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.2.4", ">= 5.2.4.3"

  spec.add_development_dependency "sqlite3"
  spec.add_dependency "daemons"
  spec.add_dependency "delayed_job"
  spec.add_dependency "rchardet"
  spec.add_dependency "net-ldap"
  spec.add_dependency "doorkeeper"
  spec.add_dependency "mail"
  spec.add_dependency "rszr"
  spec.add_dependency('aasm', '~> 4.12')
  spec.add_dependency "rails-observers"
  spec.add_dependency "business_time"
  spec.add_dependency "biz"
end
