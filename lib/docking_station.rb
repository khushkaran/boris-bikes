require_relative "bike_container"

class DockingStation
  include BikeContainer

  def initialize(options = {})
    self.capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
  end

  def broken_bikes
    bikes.select{|bike| bike.broken?}
  end

end