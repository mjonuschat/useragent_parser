# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "useragent_parser/version"

Gem::Specification.new do |s|
  s.name        = "useragent_parser"
  s.version     = UseragentParser::VERSION
  s.authors     = ["Morton Jonuschat"]
  s.email       = ["yabawock@gmail.com"]
  s.homepage    = "https://github.com/yabawock/useragent_parser"
  s.summary     = %q{A library to extract informtion from Useragent headers}
  s.description = %q{UseragentParser extracts browser and operating system information from the headers sent by most browsers and email clients}

  s.rubyforge_project = "useragent_parser"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec",       "~> 3.0"
end
