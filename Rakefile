# Copyright (c) 2009-2013 The University of Manchester, UK.
#
# See LICENCE file for details.
#
# Authors: Finn Bacall
#          Robert Haines
#          David Withers
#          Mannie Tagarira

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/tasklib'
require 'rake/testtask'
require 'rdoc/task'
require 'jeweler'

task :default => [:test]

T2FLOW_GEM_VERSION = "0.6.0"

Jeweler::Tasks.new do |s|
  s.name             = "taverna-t2flow"
  s.version          = T2FLOW_GEM_VERSION
  s.authors          = ["Finn Bacall", "Robert Haines", "David Withers", "Mannie Tagarira", "Don Cruickshank"]
  s.email            = ["support@mygrid.org.uk"]
  s.homepage         = "http://www.taverna.org.uk/"
  s.license          = "BSD-3-Clause"
  s.platform         = Gem::Platform::RUBY
  s.summary          = "Parse Taverna 2 workflows."
  s.description      = "This gem enables parsing of Taverna 2 workflows (.t2flow). "+
    " An example use would be the " +
    "diagram generation for the model representing Taverna 2 workflows, as " +
    "used in myExperiment."
  s.require_path     = "lib"
  s.test_file        = "test/run_tests.rb"
  s.has_rdoc         = true
  s.extra_rdoc_files = ["README.rdoc", "LICENCE", "CHANGES.rdoc"]
  s.rdoc_options     = ["-N", "--tab-width=2", "--main=README.rdoc"]
  s.add_development_dependency('rake', '~> 0.9.2')
  s.add_development_dependency('rdoc', '>= 3.9.4')
  s.add_development_dependency('jeweler', '~> 1.8.3')
  s.add_runtime_dependency('libxml-ruby', '>= 1.1.4')
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/run_tests.rb']
end

RDoc::Task.new do |r|
  r.main = "README.rdoc"
  lib = Dir.glob("lib/**/*.rb")
  r.rdoc_files.include("README.rdoc", "LICENCE", "CHANGES.rdoc", lib)
  r.options << "-t Taverna T2Flow Library version #{T2FLOW_GEM_VERSION}"
  r.options << "-N"
  r.options << "--tab-width=2"
end
