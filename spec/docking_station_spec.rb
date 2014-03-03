require_relative "../lib/docking_station"

describe DockingStation do
  let(:station) {DockingStation.new(:capacity => 123)}

  it "should allow setting default capacity on initialising" do
    expect(station.capacity).to eq(123)
  end

  it "should provide a list of broken bikes" do
    working_bike, broken_bike = Bike.new, Bike.new
    broken_bike.break
    station.dock(working_bike)
    station.dock(broken_bike)
    expect(station.broken_bikes).to eq([broken_bike])
  end
end