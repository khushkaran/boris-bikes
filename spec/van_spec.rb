require_relative "../lib/van"

class ContainerHolder; include BikeContainer; end

describe Van do
  let(:van) {Van.new(:capacity => 50)}
  let(:station) {ContainerHolder.new}
  let(:garage) {ContainerHolder.new}

  def test_bikes
    @working_bike, @broken_bike = Bike.new, Bike.new
    @broken_bike.break
  end

  it "should allow setting default capacity on initialising" do
    expect(van.capacity).to eq(50)
  end

  it "should only dock broken bikes from docking station" do
    test_bikes
    station.dock(@working_bike)
    station.dock(@broken_bike)
    station.broken_bikes.each do |bike|
      van.dock(bike)
    end
    expect(van.bikes).to eq([@broken_bike])
  end

  it "should only collect fixed bikes from the garage" do
    test_bikes
    garage.dock(@working_bike)
    garage.dock(@broken_bike)
    garage.available_bikes.each do |bike|
      van.dock(bike)
    end
    expect(van.bikes).to eq([@working_bike])
  end

  it "should release broken bikes to the garage" do
    test_bikes
    van.dock(@broken_bike)
    van.broken_bikes.each do |bike|
      garage.dock(bike)
    end
    expect(garage.bikes).to eq([@broken_bike])
  end

  it "should release fixed bikes to the docking station" do
    test_bikes
    van.dock(@working_bike)
    van.available_bikes.each do |bike|
      station.dock(bike)
    end
    expect(station.bikes).to eq([@working_bike])
  end

end




