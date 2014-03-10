module T2Flow
  class Port
    attr_accessor :name, :descriptions, :example_values, :semantic_annotation
  end

# This is the start node of a Datalink.  Each source has a name and a port
# which is seperated by a colon; ":".
# This is represented as "source of a processor:port_name".
# A string that does not contain a colon can often be returned, signifiying
# a workflow source as opposed to that of a processor.
  class Source < Port
  end


# This is the end node of a Datalink.  Each sink has a name and a port
# which is seperated by a colon; ":".
# This is represented as "sink of a processor:port_name".
# A string that does not contain a colon can often be returned, signifiying
# a workflow sink as opposed to that of a processor.
  class Sink < Port
  end
end
