require_relative "../lib/user"

describe User do
  let(:user) {User.new}

  it "has no bikes" do
    expect(user).not_to have_bike
  end

  it "rents a bike from a station" do
    station = double :station
    expect(station).to receive(:release_bike)
    user.rent_bike_from(station)
  end

end
