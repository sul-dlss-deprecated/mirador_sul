##
# A plain ruby class that returns mirador configuration json given a
# workspace as well as a controller context (for things like user access)
class MiradorOptionsJson
  attr_reader :context, :workspace
  def initialize(context: NullContext, workspace:)
    @context = context
    @workspace = workspace
  end

  def to_json
    workspace.mirador_options
  end

  class NullContext
  end
end
