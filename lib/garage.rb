require_relative "bike_container"

class Garage
  include BikeContainer

  def initialize(options = {})
    self.capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
  end

  def fix_bikes(bikes)
    bikes.each do |bike|
      bike.fix
    end
  end

  def accept_broken_bikes(van)
    put_in(van.broken_bikes)
    van.take_out(broken_bikes)
    fix_bikes(broken_bikes)
  end

  def release_fixed_bikes(van)
    van.put_in(available_bikes)
    take_out(van.available_bikes)
  end

end
