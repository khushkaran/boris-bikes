require_relative "../lib/van"

class ContainerHolder; include BikeContainer; end

describe Van do
  let(:van) {Van.new(:capacity => 50)}
  let(:holder) {ContainerHolder.new}

  it "should allow setting default capacity on initialising" do
    expect(van.capacity).to eq(50)
  end

  it "should only dock broken bikes from docking station" do
    working_bike, broken_bike1, broken_bike2 = Bike.new, Bike.new, Bike.new
    broken_bike1.break
    broken_bike2.break
    holder.dock(working_bike)
    holder.dock(broken_bike1)
    holder.dock(broken_bike2)
    holder.broken_bikes.each do |bike|
      van.dock(bike)
    end
    expect(van.bikes).to eq([broken_bike1, broken_bike2])
  end
end