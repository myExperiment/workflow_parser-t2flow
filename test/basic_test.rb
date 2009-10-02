$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'test/unit'
require "t2flow/model"
require "t2flow/parser"

class BasicTest < Test::Unit::TestCase
  FIXTURES = File.join(File.dirname(__FILE__), "fixtures")
  FLOW_CONTENT = IO.read("#{FIXTURES}/basic.t2flow")
  
  def setup
    @model = T2Flow::Parser.new.parse(FLOW_CONTENT)
    @procs = @model.processors
  end
  
  def test_misc
    assert_equal(@model.datalinks.size, 2)
    assert(@model.coordinations.empty?)
    assert_equal(@procs.size, 1)
    assert_equal(@model.sinks.size, 1)
    assert_equal(@model.sources.size, 1)
    assert(!@model.dependencies.empty?)    
  end
  
  def test_processor_links
    links = @model.get_processor_links(@procs.first)
    assert(links.sources.empty?)
    assert(links.sinks.empty?)
  end
end