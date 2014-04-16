class User
  def has_bike?
    false
  end

  def rent_bike_from(station)
    station.release_bike
  end
end
