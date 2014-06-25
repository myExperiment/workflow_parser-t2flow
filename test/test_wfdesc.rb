# Copyright (c) 2009-2013 The University of Manchester, UK.
#
# See LICENCE file for details.
#
# Authors: Finn Bacall
#          Robert Haines
#          David Withers
#          Mannie Tagarira

require 'test_helper'
require 't2flow/workflowprocessor'

class WfdescTest < MiniTest::Test
  
  include TestHelper
  
  def setup
    @path = File.expand_path(File.join(__FILE__, "..", "fixtures", "image_to_tiff_migration_action.t2flow"))
    @processor = T2Flow::WorkflowProcessor.new
  end

  def wfdesc
    wf = nil
    open(path) do |file|
      wf = file.read
    end
    wfdesc = @processor.extract_rdf_structure(wf) 
    puts wfdesc
  end
  
end
