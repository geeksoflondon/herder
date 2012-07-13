# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "herder/version"

Gem::Specification.new do |s|
  s.name        = "herder"
  s.version     = Herder::VERSION
  s.authors     = ["Cristiano Betta"]
  s.email       = ["cristiano@geeksoflondon.com"]
  s.homepage    = "http://github.com/geeksoflondon/herder"
  s.summary     = "The herder"
  s.description = "The herder that manages all animals talking to the hamster"

  s.rubyforge_project = "gol-herder"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'

  s.add_dependency 'activeresource'
  s.add_dependency 'reactive_resource'
  s.add_dependency 'active_resource_pagination'
  s.add_dependency 'will_paginate'
end
