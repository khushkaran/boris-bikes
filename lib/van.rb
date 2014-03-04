require_relative "bike_container"

class Van
  include BikeContainer

  def initialize(options = {})
    fetched_capacity = options.fetch(:capacity)
    self.capacity = fetched_capacity.is_a?(Integer) && fetched_capacity >= 0 ? fetched_capacity : DEFAULT_CAPACITY
  end

  def deliver_broken_bikes(garage)
    garage.put_in(broken_bikes)
    take_out(garage.broken_bikes)
  end

  def deliver_fixed_bikes(station)
    station.put_in(available_bikes)
    take_out(station.available_bikes)
  end

  def accept_fixed_bikes(garage)
    put_in(garage.available_bikes)
    garage.take_out(available_bikes)
  end

  def accept_broken_bikes(station)
    put_in(station.broken_bikes)
    station.take_out(broken_bikes)
  end

end
