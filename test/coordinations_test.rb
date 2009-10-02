$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'test/unit'
require "t2flow/model"
require "t2flow/parser"
require "t2flow/dot"

class BasicTest < Test::Unit::TestCase
  FIXTURES = File.join(File.dirname(__FILE__), "fixtures")
  FLOW_CONTENT = IO.read("#{FIXTURES}/coordinated.t2flow")
  
  def setup
    @model = T2Flow::Parser.new.parse(FLOW_CONTENT)
  end
  
  def test_misc
    assert(@model.coordinations.size, 1)
    assert_equal(@model.processors.size, 2)
    assert(@model.sinks.empty?)
    assert(@model.sources.empty?)
    assert_equal(@model.dependencies, nil)
  end
end