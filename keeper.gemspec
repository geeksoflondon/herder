# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "keeper/version"

Gem::Specification.new do |s|
  s.name        = "gol-keeper"
  s.version     = Keeper::VERSION
  s.authors     = ["Cristiano Betta"]
  s.email       = ["cristiano@geeksoflondon.com"]
  s.homepage    = "http://github.com/geeksoflondon/keeper"
  s.summary     = "The zoo keeper"
  s.description = "The zoo keeper that allows all animals to talk to the hamster"

  s.rubyforge_project = "keeper"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
end
