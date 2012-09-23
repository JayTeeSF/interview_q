class Traveler
  attr_reader :name, :travel_time
  def initialize(options = {})
    @travel_time = options[:travel_time] || nil
    raise ArgumentError, "Must specify a travel_time > 0" if travel_time.nil? || travel_time <= 0
    @name = options[:name].to_s || "Traveler_#{travel_time}"
  end

  def to_s
    name
  end
end
