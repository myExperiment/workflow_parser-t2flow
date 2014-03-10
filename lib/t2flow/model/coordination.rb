# This is a representation of the 'Run after...' function in Taverna
# where the selected processor or workflow is set to run after another.
module T2Flow
  class Coordination
    # The name of the processor/workflow which is to run first.
    attr_accessor :control

    # The name of the processor/workflow which is to run after the control.
    attr_accessor :target
  end
end
