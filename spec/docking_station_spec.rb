require_relative "../lib/docking_station"

describe DockingStation do
  let(:station) {DockingStation.new(:capacity => 20)}

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

end
