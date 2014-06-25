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
require 't2flow/version'

task :default => [:test]

T2FLOW_GEM_VERSION = T2Flow::VERSION

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
