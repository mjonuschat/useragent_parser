# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "useragent_parser/version"

Gem::Specification.new do |s|
  s.name        = "useragent_parser"
  s.version     = UseragentParser::VERSION
  s.authors     = ["Morton Jonuschat"]
  s.email       = ["yabawock@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "useragent_parser"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake",        "~> 0.9.0"
  s.add_development_dependency "rspec",       "~> 2.6.0"
  s.add_development_dependency "multi_json",  "~> 1.0.1"
end
