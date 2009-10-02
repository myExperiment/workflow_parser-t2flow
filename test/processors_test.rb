$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'test/unit'
require "t2flow/model"
require "t2flow/parser"
require "t2flow/dot"

class BasicTest < Test::Unit::TestCase
  FIXTURES = File.join(File.dirname(__FILE__), "fixtures")
  FLOW_CONTENT = IO.read("#{FIXTURES}/processors.t2flow")
  
  def setup
    @model = T2Flow::Parser.new.parse(FLOW_CONTENT)
  end
  
  def test_misc
    assert(@model.datalinks.empty?)
    assert_equal(@model.processors.size, 7)
  end

  def test_get_processors
    assert(@model.local_workers.empty?)
    assert_equal(@model.web_services.size, 3)
    assert_equal(@model.beanshells.size, 1)
  end
end