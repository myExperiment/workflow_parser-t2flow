# Copyright (c) 2009-2013 The University of Manchester, UK.
#
# See LICENCE file for details.
#
# Authors: Finn Bacall
#          Robert Haines
#          David Withers
#          Mannie Tagarira

require 'test_helper'

class ComponentWorkflowTest < MiniTest::Test
  
  include TestHelper
  
  def setup
    path = File.expand_path(File.join(__FILE__, "..", "fixtures", "image_to_tiff_migration_action.t2flow"))
    @image_migration_wf = T2Flow::Parser.new.parse(File.new(path))
  end
  
  def test_image_migration_workflow
    generic_model_test(@image_migration_wf)
    
    assert_count(@image_migration_wf.processors, 1, "@image_migration_wf.processors")
    assert_count(@image_migration_wf.sources, 2, "@image_migration_wf.sources")
    assert_count(@image_migration_wf.sinks, 0, "@image_migration_wf.sinks")
    assert_count(@image_migration_wf.datalinks, 2, "@image_migration_wf.datalinks")
    assert_count(@image_migration_wf.coordinations, 0, "@image_migration_wf.coordinations")
  end

  def test_semantic_annotations
    refute_nil(@image_migration_wf.sources[0].semantic_annotation)
    assert_equal(@image_migration_wf.sources[0], @image_migration_wf.sources[0].semantic_annotation.subject)
    assert_equal("text/rdf+n3", @image_migration_wf.sources[0].semantic_annotation.type)
    assert_equal("[]<http://scape-project.eu/pc/vocab/profiles#hasPortType><http://scape-project.eu/pc/vocab/profiles#FromURIPort>.",
                 @image_migration_wf.sources[0].semantic_annotation.content.gsub(/\s+/, ""),
                 "@image_migration_wf.sources[0].semantic_annotation")

    refute_nil(@image_migration_wf.sources[1].semantic_annotation)
    assert_equal(@image_migration_wf.sources[1], @image_migration_wf.sources[1].semantic_annotation.subject)
    assert_equal("text/rdf+n3", @image_migration_wf.sources[1].semantic_annotation.type)
    assert_equal("[]<http://scape-project.eu/pc/vocab/profiles#hasPortType><http://scape-project.eu/pc/vocab/profiles#ToURIPort>.",
                 @image_migration_wf.sources[1].semantic_annotation.content.gsub(/\s+/, ""),
                 "@image_migration_wf.sources[1].semantic_annotation")

    refute_nil(@image_migration_wf.processors[0].semantic_annotation)
    assert_equal(@image_migration_wf.processors[0], @image_migration_wf.processors[0].semantic_annotation.subject)
    assert_equal("text/rdf+n3", @image_migration_wf.processors[0].semantic_annotation.type)
    assert_equal("[]<http://scape-project.eu/pc/vocab/profiles#hasDependency><http://scape-project.eu/pc/vocab/profiles#imagemagick-image2tiff>.",
                 @image_migration_wf.processors[0].semantic_annotation.content.gsub(/\s+/, ""),
                 "@image_migration_wf.processors[0].semantic_annotation")
  end

  def test_parses_component_information
    p = File.expand_path(File.join(__FILE__, "..", "fixtures", "component_using_workflow.t2flow"))
    wf = T2Flow::Parser.new.parse(File.new(p))

    proc = wf.processors[0]
    refute_nil(proc)
    refute_nil(proc.configuration[:component])
    assert_equal('http://www.myexperiment.org', proc.configuration[:component][:registry])
    assert_equal('SCAPE Image Characterisation Component', proc.configuration[:component][:family_name])
    assert_equal('Extract PNG dimensions', proc.configuration[:component][:name])
    assert_equal(2, proc.configuration[:component][:version])
  end
end
