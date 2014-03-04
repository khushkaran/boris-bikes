require_relative "../lib/van"

class ContainerHolder; include BikeContainer; end

describe Van do
  let(:van) {Van.new(:capacity => 50)}
  let(:holder) {ContainerHolder.new}
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
    holder.dock(@working_bike)
    holder.dock(@broken_bike)
    holder.broken_bikes.each do |bike|
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
end