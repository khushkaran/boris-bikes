require_relative "../lib/garage"
require_relative "../lib/van"
require_relative "../lib/docking_station"

describe Garage do
  let(:garage) {Garage.new(:capacity => 100)}
  let(:station) {DockingStation.new(:capacity => 20)}
  let(:van) {Van.new(:capacity => 50)}

  def test_bikes
    @working_bike, @broken_bike = Bike.new, Bike.new
    @broken_bike.break
  end

  def fill_garage
    100.times {garage.dock(Bike.new)}
  end

  it "should allow setting default capacity on initialising" do
    expect(garage.capacity).to eq(100)
  end

  it "should not expect more than 100 bikes" do
    expect(garage).not_to be_full
    fill_garage
    expect(garage).to be_full
  end

  it "should only dock broken bikes into garage from van" do
    test_bikes
    van.dock(@broken_bike)
    garage.accept_broken_bikes(van)
    expect(garage.bikes).to eq([@broken_bike])
    expect(van.bikes.count).to eq(0)
  end

  it "should only release fixed bikes into van from garage" do
    test_bikes
    van.dock(@broken_bike)
    garage.accept_broken_bikes(van)
    garage.release_fixed_bikes(van)
    expect(van.bikes).to eq([@broken_bike])
    expect(garage.bikes.count).to eq(0)
  end
end
