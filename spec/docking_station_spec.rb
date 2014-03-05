require_relative "../lib/docking_station"
require_relative "../lib/van"

describe DockingStation do
  let(:station) {DockingStation.new(:capacity => 20)}
  let(:van) {Van.new(:capacity => 50)}

  def test_bikes
    @working_bike, @broken_bike = Bike.new, Bike.new
    @broken_bike.break
  end

  def fill_station
    20.times {station.dock(Bike.new)}
  end

  it "should allow setting default capacity on initialising" do
    expect(station.capacity).to eq(20)
  end

  it "should not expect more than 20 bikes" do
    expect(station).not_to be_full
    fill_station
    expect(station).to be_full
  end

  it "should only dock working bikes into docking station from van" do
    test_bikes
    van.dock(@working_bike)
    station.accept_working_bikes(van)
    expect(station.bikes).to eq([@working_bike])
    expect(van.bikes.count).to eq(0)
  end

  it "should only release broken bikes into van from docking station" do
    test_bikes
    station.dock(@broken_bike)
    station.release_broken_bikes(van)
    expect(van.bikes).to eq([@broken_bike])
    expect(station.bikes.count).to eq(0)
  end

end
