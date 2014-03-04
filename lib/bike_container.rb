module BikeContainer
  DEFAULT_CAPACITY = 10

  def bikes
    @bikes ||= []
  end

  def capacity
    @capacity ||= DEFAULT_CAPACITY
  end

  def capacity=(value)
    @capacity = value
  end

  def dock(bike)
    raise "Container is full/No Bike as argument" if full? || !bike.instance_of?(Bike)
    bikes << bike
  end

  def release(bike)
    raise "No bikes docked/No Bike as argument" if empty? || !bike.instance_of?(Bike)
    bikes.delete(bike)
  end

  def put_in(bikes)
    bikes.each {|bike| dock(bike)}
  end

  def take_out(bikes)
    bikes.each {|bike| release(bike)}
  end

  def full?
    bikes.count == capacity
  end

  def empty?
    bikes.count == 0
  end

  def available_bikes
    bikes.reject{|bike| bike.broken?}
  end

  def broken_bikes
    bikes.select{|bike| bike.broken?}
  end
end
