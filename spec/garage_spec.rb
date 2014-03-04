require_relative "../lib/garage"

class ContainerHolder; include BikeContainer; end

describe Garage do
  let(:garage) {Van.new(:capacity => 100)}
  let(:station) {ContainerHolder.new(:capacity => 20)}
  let(:van) {ContainerHolder.new(:capacity => 50)}

  it "should allow setting default capacity on initialising" do
    expect(garage.capacity).to eq(100)
  end
end
