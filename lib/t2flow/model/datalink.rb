# This represents a connection between any of the following pair of entities:
# {processor -> processor}, {workflow -> workflow}, {workflow -> processor},
# and {processor -> workflow}.
module T2Flow
  class Datalink
    # The name of the source (the starting point of the connection).
    attr_accessor :source

    # The name of the sink (the endpoint of the connection).
    attr_accessor :sink
  end
end
