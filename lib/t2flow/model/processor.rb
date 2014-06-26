# This is the (shim) object within the workflow.  This can be a beanshell,
# a webservice, a workflow, etc...
module T2Flow
  class Processor
    # A string containing name of the processor.
    attr_accessor :name

    # A string containing the description of the processor if available.
    # Returns nil otherwise.
    attr_accessor :descriptions

    def description
      @descriptions.first
    end

    # A string for the type of processor, e.g. beanshell, workflow, webservice, etc...
    attr_accessor :type

    # For processors that have type "dataflow", this is the the reference
    # to the dataflow.  For all other processor types, this is nil.
    attr_accessor :dataflow_id

    # This only has a value in beanshell processors.  This is the actual script
    # embedded with the processor which does all the "work"
    attr_accessor :script

    # This is a list of inputs that the processor can take in.
    attr_accessor :inputs

    # This is a list of outputs that the processor can produce.
    attr_accessor :outputs

    # For processors of type "arbitrarywsdl", this is the URI to the location
    # of the wsdl file.
    def wsdl
      @configuration["wsdlURI"]
    end

    # For processors of type "arbitrarywsdl", this is the operation invoked.
    def wsdl_operation
      @configuration["wsdlOperationName"]
    end

    # For soaplab and biomoby services, this is the endpoint URI.
    def endpoint
      @configuration["serviceURI"]
    end

    # Authority name for the biomoby service.
    def biomoby_authority_name
      @configuration["biomoby_authority_name"]
    end

    # Service name for the biomoby service. This is not necessarily the same
    # as the processors name.
    def biomoby_service_name
      @configuration["biomoby_service_name"]
    end

    # Category for the biomoby service.
    def biomoby_category
      @configuration["biomoby_category"]
    end

    # Value for string constants
    def value
      @configuration["value"]
    end

    attr_accessor :semantic_annotation

    # Hash containing details of the processors configuration.
    attr_accessor :configuration

    def initialize
      @descriptions = []
      @configuration = {}
      @inputs = []
      @outputs = []
    end

    def to_json
      json = {
        "@type" => type,
        "label" => name,
        "comment" => type,
        "description" => description,
        "script" => script,
        "hasInput" => inputs.map do |port|
          # TODO: Keep these around for mathcing ids with datalinks
          p = Source.new
          p.name = port
          p.to_json
        end,
        "hasOutput" => outputs.map do |port|
          # TODO: Keep these around for mathcing ids with datalinks
          p = Sink.new
          p.name = port
          p.to_json
        end,

      }.merge(configuration).delete_if{|k,v| v.nil?}
      return json
    end

  end

# This object is returned after invoking model.get_processor_links(processor)
# .  The object contains two lists of processors.  Each element consists of:
# the input or output port the processor uses as a link, the name of the
# processor being linked, and the port of the processor used for the linking,
# all seperated by a colon (:) i.e.
#   my_port:name_of_processor:processor_port
  class ProcessorLinks
    # The processors whose output is fed as input into the processor used in
    # model.get_processors_linked_to(processor).
    attr_accessor :sources

    # A list of processors that are fed the output from the processor (used in
    # model.get_processors_linked_to(processor) ) as input.
    attr_accessor :sinks
  end
end
