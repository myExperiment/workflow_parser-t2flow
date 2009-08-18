# This is the module containing the T2Flow model implementation i.e. the model structure/definition and all its internals.

module T2Flow # :nodoc:
  
  # The model for a given Taverna 2 workflow.
  class Model
    # The list of all the dataflows that make up the workflow.
    attr_accessor :dataflows
    
    # The list of any dependencies that have been found inside the workflow.
    attr_accessor :dependencies
    
    # Creates an empty model for a Taverna 2 workflow.
    def initialize
      @dataflows = []
    end
    
    # Retrieve the top-level dataflow ie the MAIN (containing) dataflow
    def top_level
      @dataflows[0]
    end
    
    # Retrieve the dataflow with the given ID
    def dataflow(df_id)
      df = @dataflows.select { |x| x.dataflow_id == df_id }
      return df[0]
    end
    
    # Retrieve ALL the processors containing beanshells within the workflow.
    def beanshells
      beanshells = []
      @dataflows.each { |dataflow| 
        dataflow.beanshells.each { |bean|
          beanshells << bean
        }
      }
      return beanshells
    end
        
    # Retrieve the annotations within the workflow.
    # In the event that the workflow is nested, 
    # retrieve the top-level annotations.
    def annotations
      @dataflows[0].annotations
    end
        
    # Retrieve the sources/inputs to the workflow
    def sources
      @dataflows[0].sources
    end
        
    # Retrieve the sinks/outputs to the workflow
    def sinks
      @dataflows[0].sinks
    end
          
    # Retrieve the unique dataflow ID for the top level dataflow.
    def dataflow_id
      @dataflows[0].dataflow_id
    end
  end
  
  
  
  # The entities within the Taverna 2 mdoel which contains the different 
  # elements of the workflows; processors, sinks, sources, etc...
  class Dataflow
    # This returns a DataflowAnnotation object.
    attr_reader :annotations
    
    # Retrieve the list of processors specific to the dataflow.
    attr_reader :processors
    
    # Retrieve the list of datalinks specific to the dataflow.
    attr_reader :datalinks
    
    # Retrieve the list of sources specific to the dataflow.
    attr_reader :sources
    
    # Retrieve the list of sinks specific to the dataflow.
    attr_reader :sinks
    
    # Retrieve the list of coordinations specific to the dataflow.
    attr_reader :coordinations
    
    # The unique identifier of the dataflow.
    attr_accessor :dataflow_id
    
    # Creates a new Dataflow object.
    def initialize
      @annotations = DataflowAnnotation.new
      @processors = []
      @datalinks = []
      @sources = []
      @sinks = []
      @coordinations = []
    end
    
    # Retrieve beanshell processors specific to this dataflow.
    def beanshells
      @processors.select { |x| x.type == "beanshell" }
    end
  end
  
  
  
  # This is the (shim) object within the workflow.  This can be a beanshell,
  # a webservice, a workflow, etc...
  class Processor
    # A string containing name of the processor.
    attr_accessor :name 
    
    # A string containing the description of the processor if available.  
    # Returns nil otherwise.
    attr_accessor :description
    
    # A string for the type of processor, e.g. beanshell, workflow, webservice, etc...
    attr_accessor :type 
    
    # For processors that have type == "dataflow", this is the the reference 
    # to the dataflow.  For all other processor types, this is nil.
    attr_accessor :dataflow_id
    
    # This only has a value in beanshell processors.  This is the actual script
    # embedded with the processor which does all the "work"
    attr_accessor :script
    
    # This is a list of inputs that the processor can take in.
    attr_accessor :inputs
    
    # This is a list of outputs that the processor can produce.
    attr_accessor :outputs
  end


  
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
  end
  
  
  
  # This represents a connection between any of the following pair of entities:
  # {processor -> processor}, {workflow -> workflow}, {workflow -> processor}, 
  # and {processor -> workflow}.
  class Datalink
    # The name of the source (the starting point of the connection).
    attr_accessor :source
    
    # The name of the sink (the endpoint of the connection).
    attr_accessor :sink
  end
  
  
  
  # This is a representation of the 'Run after...' function in Taverna
  # where the selected processor or workflow is set to run after another.
  class Coordination
    # The name of the processor/workflow which is to run first.
    attr_accessor :control
    
    # The name of the processor/workflow which is to run after the control.
    attr_accessor :target
  end
  
  
  
  # This is the start node of a Datalink.  Each source has a name and a port
  # which is seperated by a colon; ":".
  # This is represented as "source of a processor:port_name".
  # A string that does not contain a colon can often be returned, signifiying
  # a workflow source as opposed to that of a processor.
  class Source
  	attr_accessor :name
  end
  
  
  
  # This is the start node of a Datalink.  Each sink has a name and a port
  # which is seperated by a colon; ":".
  # This is represented as "sink of a processor:port_name".
  # A string that does not contain a colon can often be returned, signifiying
  # a workflow sink as opposed to that of a processor.
  class Sink
	  attr_accessor :name
  end  	

end
