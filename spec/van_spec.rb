require_relative "../lib/van"
require_relative "../lib/docking_station"
require_relative "../lib/garage"

describe Van do
  let(:van) {Van.new(:capacity => 50)}
  let(:station) {DockingStation.new(:capacity => 20)}
  let(:garage) {Garage.new(:capacity => 100)}

  def test_bikes
    @working_bike, @broken_bike = Bike.new, Bike.new
    @broken_bike.break
  end

  it "should allow setting default capacity on initialising" do
    expect(van.capacity).to eq(50)
  end

  it "should only dock broken bikes into van from docking station" do
    test_bikes
    station.dock(@working_bike)
    station.dock(@broken_bike)
    van.put_in(station.broken_bikes)
    station.take_out(van.broken_bikes)
    expect(van.bikes).to eq([@broken_bike])
    expect(station.bikes.count).to eq(1)
  end

  it "should only dock fixed bikes into van from the garage" do
    test_bikes
    garage.dock(@working_bike)
    garage.dock(@broken_bike)
    van.put_in(garage.available_bikes)
    garage.take_out(van.available_bikes)
    expect(van.bikes).to eq([@working_bike])
    expect(garage.bikes.count).to eq(1)
  end

  it "should release broken bikes from the van to the garage" do
    test_bikes
    van.dock(@broken_bike)
    garage.put_in(van.broken_bikes)
    van.take_out(garage.broken_bikes)
    expect(garage.bikes).to eq([@broken_bike])
    expect(van.bikes.count).to eq(0)
  end

  it "should release fixed bikes from the van to the docking station" do
    test_bikes
    van.dock(@working_bike)
    station.put_in(van.available_bikes)
    van.take_out(station.available_bikes)
    expect(station.bikes).to eq([@working_bike])
    expect(van.bikes.count).to eq(0)
  end

end
