$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ffcrm_supervised_mailings/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ffcrm_supervised_mailings"
  s.version     = FfcrmSupervisedMailings::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of FfcrmSupervisedMailings."
  s.description = "TODO: Description of FfcrmSupervisedMailings."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "nestful"
  s.add_development_dependency "sqlite3"
end
