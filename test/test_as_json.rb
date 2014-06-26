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
require 'json/ld'
require 'rdf/turtle'


class JsonTest < MiniTest::Test

  include TestHelper

  WFDESC = RDF::Vocabulary.new("http://purl.org/wf4ever/wfdesc#")
  ROTERMS = RDF::Vocabulary.new("http://purl.org/wf4ever/roterms#")
  CNT = RDF::Vocabulary.new("http://www.w3.org/2011/content#")
  DC = RDF::Vocabulary.new("http://purl.org/dc/elements/1.1/")

  def setup
    @path = File.expand_path(File.join(__FILE__, "..", "fixtures", "image_to_tiff_migration_action.t2flow"))
    open(@path) do |file|
      @wf = file.read
    end
  end

  def test_to_json
    processor = T2Flow::WorkflowProcessor.new(@wf)
    json = processor.to_json

    puts json

    assert_equal "https://w3id.org/ro/roterms/context", json["@context"]
    assert_equal "Workflow", json["@type"]

    # Parse as JSON-LD
    graph = RDF::Graph.new << JSON::LD::API.toRdf(json)
    # Output as Turtle for debug
    puts graph.dump(:ttl)


    # Attempt to match expected structure
    query = RDF::Query.new({
       :workflow => {
          RDF.type => WFDESC.Workflow,
          DC.creator => :creator,
          RDF::RDFS.label => :wfLabel,
          RDF::DC.title => :title,
          WFDESC.hasInput => {
            RDF::RDFS.label => :inputLabel,
            ROTERMS.exampleValue => {
              CNT.chars => :inputExample
            }
          },
          WFDESC.hasSubProcess => {
              RDF::RDFS.label => :procLabel,
              RDF::RDFS.comment => :procComment
          }
       }
    })
    count = 0
    query.execute(graph) do |solution|
      count += 1
      assert_equal("from_uri", solution.inputLabel.to_s)
      assert_equal("example", solution.inputExample.to_s)
    end
    assert_equal(1, count, "Could not correctly match input_query")



  end

  end
