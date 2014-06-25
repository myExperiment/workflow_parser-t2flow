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
require 'rdf/turtle'
require 'stringio'


class WfdescTest < MiniTest::Test
  
  include TestHelper
  
  WFDESC = RDF::Vocabulary.new("http://purl.org/wf4ever/wfdesc#")
  BIOCAT = RDF::Vocabulary.new("http://biocatalogue.org/attribute/")

  def setup
    @path = File.expand_path(File.join(__FILE__, "..", "fixtures", "image_to_tiff_migration_action.t2flow"))
    # NOTE: identifier and name varies per t2flow
    @base = "http://ns.taverna.org.uk/2010/workflowBundle/16841f82-e1fe-4527-b7ef-411c4c59493b/workflow/Image_to_tiff_migrat/"
    open(@path) do |file|
      @wf = file.read
    end
  end

  def test_wfdesc
    wfdesc = T2Flow::WorkflowProcessor.extract_rdf_structure(@wf)
    #puts wfdesc
    graph = RDF::Graph.new
    RDF::Turtle::Reader.new(StringIO.new(wfdesc)) do |reader|
      reader.each_statement do |statement|
        graph << statement
      end
    end
    input_query = RDF::Query.new({
       :workflow => {
          RDF.type => WFDESC.Workflow,
          WFDESC.hasInput => {
            RDF::RDFS.label => :inputLabel,
            BIOCAT.exampleData => :inputExample
          }
       }
    })
    count = 0
    input_query.execute(graph) do |solution|
      count += 1
      assert_equal("from_uri", solution.inputLabel.to_s)
      assert_equal("example", solution.inputExample.to_s)
    end
    assert_equal(1, count, "Could not correctly match input_input_query")

     

  end
  
end
