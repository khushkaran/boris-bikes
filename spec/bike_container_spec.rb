require_relative "../lib/bike_container"

class ContainerHolder; include BikeContainer; end

describe BikeContainer do
  let(:bike) {Bike.new}
  let(:holder) {ContainerHolder.new}

  def fill_holder(holder)
    10.times {holder.dock(Bike.new)}
  end

  it "should accept a bike" do
    expect(holder.bikes.count).to eq(0)
    holder.dock(bike)
    expect(holder.bikes.count).to eq(1)
  end

  it "should release a bike" do
    holder.dock(bike)
    holder.release(bike)
    expect(holder.bikes.count).to eq(0)
  end

  it "should know when it's full" do
    expect(holder).not_to be_full
    fill_holder holder
    expect(holder).to be_full
  end

  it "should not accept a bike if it is full" do
    fill_holder holder
    expect(lambda {holder.dock(bike)}).to raise_error(RuntimeError)
  end

  it "should provide the list of available bikes" do
    working_bike, broken_bike = Bike.new, Bike.new
    broken_bike.break
    holder.dock(working_bike)
    holder.dock(broken_bike)
    expect(holder.available_bikes).to eq([working_bike])
  end

  it "should not release a bike if it is empty" do
    expect(lambda {holder.release(bike)}).to raise_error(RuntimeError)
  end

  it "should not return anything if pass release/dock a non-bike argument" do
    expect(lambda {holder.release("haha")}).to raise_error(RuntimeError)
    expect(lambda {holder.dock("haha")}).to raise_error(RuntimeError)
  end

  it "should provide a list of broken bikes" do
    working_bike, broken_bike = Bike.new, Bike.new
    broken_bike.break
    holder.dock(working_bike)
    holder.dock(broken_bike)
    expect(holder.broken_bikes).to eq([broken_bike])
  end
end





