# The entities within the Taverna 2 mdoel which contains the different
# elements of the workflows; processors, sinks, sources, etc...
module T2Flow
  class Dataflow
    # This returns a DataflowAnnotation object.
    attr_accessor :annotations

    # Retrieve the list of processors specific to the dataflow.
    attr_accessor :processors

    # Retrieve the list of datalinks specific to the dataflow.
    attr_accessor :datalinks

    # Retrieve the list of sources specific to the dataflow.
    attr_accessor :sources

    # Retrieve the list of sinks specific to the dataflow.
    attr_accessor :sinks

    # Retrieve the list of coordinations specific to the dataflow.
    attr_accessor :coordinations

    # The unique identifier of the dataflow.
    attr_accessor :dataflow_id

    # The role of the workflow
    attr_accessor :role

    # Creates a new Dataflow object.
    def initialize
      @annotations = DataflowAnnotation.new
      @processors = []
      @datalinks = []
      @sources = []
      @sinks = []
      @coordinations = []
    end

    def name
      @annotations.name
    end

    # Retrieve beanshell processors specific to this dataflow.
    def beanshells
      @processors.select { |x| x.type == "beanshell" }
    end
  end


# TODO: Remove this class. Not useful
# This is the annotation object specific to the dataflow it belongs to.
# A DataflowAnnotation contains metadata about a given dataflow element.
  class DataflowAnnotation
    # The name used of the dataflow
    attr_accessor :name

    # A list of titles that have been assigned to the dataflow.
    attr_accessor :titles

    # A list ot descriptive strings about the dataflow.
    attr_accessor :descriptions

    # A list of authors of the dataflow
    attr_accessor :authors

    attr_accessor :semantic_annotation

    def initialize
      @authors, @descriptions, @titles  = [], [], []
    end
  end
end