#!/usr/bin/ruby

spec = Gem::Specification.new do |s| 
  s.name = "taverna-t2flow"
  s.version = "0.1.1"
  s.date = "2009-09-16"
  s.summary = "Support for interacting with the Taverna 2 workflow system (T2Flow)."
  s.description = "This a gem developed by myGrid for the purpose of interacting with Taverna 2 workflows.  An example use would be the image genaration for the model representing Taverna 2 workflows as used in myExperiment."
  
  s.authors = ["Emmanuel Tagarira", "David Withers"]
  s.email = "mannie@mygrid.org.uk"
  s.homepage = "http://www.mygrid.org.uk/"
  
  s.files = ["lib/t2flow", "lib/t2flow/dot.rb", "lib/t2flow/model.rb", "lib/t2flow/parser.rb", "README.rdoc", "LICENCE", "ChangeLog.rdoc"]
  s.extra_rdoc_files = ["README.rdoc", "LICENCE", "ChangeLog.rdoc"]
  s.has_rdoc = true
  
  s.rdoc_options = ["-N", "--tab-width=2", "--main=README.rdoc", "--exclude='t2flow.gemspec|test'"]

  s.autorequire = "t2flow"
  s.require_paths = ["lib"]
  s.platform = Gem::Platform::RUBY 

  s.add_dependency("libxml-ruby", ">=1.1.3")
  s.add_dependency("rdoc", ">=2.4.3")
  s.add_dependency("darkfish-rdoc", ">=1.1.5")
  s.required_ruby_version = Gem::Requirement.new(">=1.0.1")
  s.rubygems_version = "1.3.5"
  
  s.specification_version = 1 if s.respond_to? :specification_version=
  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.cert_chain = nil  
end
