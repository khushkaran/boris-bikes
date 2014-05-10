require_relative "bike_container"

class DockingStation
  include BikeContainer

  def initialize(options = {})
    self.capacity = options[:capacity]
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
