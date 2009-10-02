$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'test/unit'
require "t2flow/model"
require "t2flow/parser"
require "t2flow/dot"

class NestedTest < Test::Unit::TestCase
  FIXTURES = File.join(File.dirname(__FILE__), "fixtures")
  FLOW_CONTENT = IO.read("#{FIXTURES}/nested.t2flow")
  
  def setup
    @model = T2Flow::Parser.new.parse(FLOW_CONTENT)
  end
  
  def test_links
    assert_equal(@model.datalinks.size, 3)
    assert_equal(@model.all_datalinks.size, 5)
  end
  
  def test_sources
    assert_equal(@model.sources.size, 1)
    assert_equal(@model.all_sources.size, 2)
  end
  
  def test_sinks
    assert_equal(@model.sinks.size, 2)
    assert_equal(@model.all_sinks.size, 3)
  end
  
  def test_get_processors
    assert(@model.local_workers.size, 1)
    assert_equal(@model.web_services.size, 1)
    assert_equal(@model.beanshells.size, 2)
  end
end