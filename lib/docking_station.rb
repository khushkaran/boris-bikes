require_relative "bike_container"

class DockingStation
  include BikeContainer

  def initialize(options = {})
    fetched_capacity = options.fetch(:capacity)
    self.capacity = fetched_capacity.is_a?(Integer) && fetched_capacity >= 0 ? fetched_capacity : DEFAULT_CAPACITY
  end

  def accept_working_bikes(van)
    put_in(van.available_bikes)
    van.take_out(available_bikes)
  end

  def release_broken_bikes(van)
    van.put_in(broken_bikes)
    take_out(van.broken_bikes)
  end

end
