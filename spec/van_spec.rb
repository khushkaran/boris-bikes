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

  def fill_van(van)
    50.times {
      bike = Bike.new
      bike.break
      van.dock(bike)
    }
  end

  it "should allow setting default capacity on initialising" do
    expect(van.capacity).to eq(50)
  end

  it "should not accept more 50 bikes" do
    expect(van).not_to be_full
    fill_van van
    expect(van).to be_full
  end

  it "should only dock broken bikes into van from docking station" do
    test_bikes
    station.dock(@working_bike)
    station.dock(@broken_bike)
    van.accept_broken_bikes(station)
    expect(van.bikes).to eq([@broken_bike])
    expect(station.bikes.count).to eq(1)
  end

  it "should only dock fixed bikes into van from the garage" do
    test_bikes
    garage.dock(@working_bike)
    garage.dock(@broken_bike)
    van.accept_fixed_bikes(garage)
    expect(van.bikes).to eq([@working_bike])
    expect(garage.bikes.count).to eq(1)
  end

  it "should release broken bikes from the van to the garage" do
    test_bikes
    van.dock(@broken_bike)
    van.deliver_broken_bikes(garage)
    expect(garage.bikes).to eq([@broken_bike])
    expect(van.bikes.count).to eq(0)
  end

  it "should release fixed bikes from the van to the docking station" do
    test_bikes
    van.dock(@working_bike)
    van.deliver_fixed_bikes(station)
    expect(station.bikes).to eq([@working_bike])
    expect(van.bikes.count).to eq(0)
  end

end
