class AnalyticsManager
  attr_reader :events

  def initialize
    @events = {}
  end

  [:alias, :identify, :people_set, :reset].each do |method|
    define_method(method) do |params|
      @events[method] = params
    end
  end

  def track(*params)
    @events[:track] ||= []
    params.each do |param|
      @events[:track].push(param)
    end
  end
end
