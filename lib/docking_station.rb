require_relative "bike_container"

class DockingStation
  include BikeContainer

  def initialize(options = {})
    fetched_capacity = options.fetch(:capacity)
    self.capacity = fetched_capacity.is_a?(Integer) && fetched_capacity >= 0 ? fetched_capacity : DEFAULT_CAPACITY
  end

end
