# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "course_scraper/version"

Gem::Specification.new do |s|
  s.name        = "course_scraper"
  s.version     = CourseScraper::VERSION
  s.authors     = ["Josep M. Bach"]
  s.email       = ["josep.m.bach@gmail.com"]
  s.homepage    = "http://github.com/codegram/course_scraper"
  s.summary     = %q{Gives you a list of all courses in Spanish vocational education.}
  s.description = %q{Gives you a list of all courses in Spanish vocational education.}

  s.rubyforge_project = "course_scraper"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "capybara"
  s.add_development_dependency "vcr"
  s.add_development_dependency "mocha"
  s.add_development_dependency "minitest"
end
