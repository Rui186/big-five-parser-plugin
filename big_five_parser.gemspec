$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "big_five_parser/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "big_five_parser"
  spec.version     = BigFiveParser::VERSION
  spec.authors     = ["Rui"]
  spec.email       = ["rui1765428404@gmail.com"]
  # spec.homepage    = "TODO"
  spec.summary     = "The Big 5 Test Result Parser."
  spec.description = "This gem parse the big 5 test resoult into JSON format"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails"

  spec.add_development_dependency("rspec")
  spec.add_development_dependency("byebug")
  spec.add_development_dependency("factory_bot")
end
