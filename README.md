Boris Bikes [![Code Climate](https://codeclimate.com/github/khushkaran/boris-bikes.png)](https://codeclimate.com/github/khushkaran/boris-bikes)
---
This was the week 3 project @makersacademy set by
[@shadchnev](https://github.com/shadchnev). For this project
we built a system based on the London Boris Bikes initiative.
Users can collect and dock bikes, however, bikes can break
in which case they need repairing, involving the collection
of bikes by a van. They are taken to the garage, once
repaired are collected again and dropped off at the docking
station.

### Technologies
* Ruby
* Git
* Object-oriented-programming
* Test-driven-development with RSpec
* CRC (class-responsibility-collaboration) cards.

### Instructions
To run the application run `irb`:

```ruby
require "./lib/bike"
=> true
require "./lib/docking_station"
=> true
require "./lib/garage"
=> true
require "./lib/user"
=> true
require "./lib/van"
=> true
```

Docking bikes inside a station:

```ruby
bike = Bike.new
=> #<Bike:0x007f9a522d0e30 @broken=false>
station = DockingStation.new({capacity: 20})
=> #<DockingStation:0x007f9a5288f498 @capacity=20>
station.dock(bike)
=> [#<Bike:0x007f9a522d0e30 @broken=false>]
station.dock(broken_bike)
=> [#<Bike:0x007f9a522d0e30 @broken=false>, #<Bike:0x007f9a5287c190 @broken=true>]
station.available_bikes
=> [#<Bike:0x007f9a522d0e30 @broken=false>]
```

Loading a broken bike to the van and taking it to the garage to fix it:

```ruby
van = Van.new({capacity: 50})
=> #<Van:0x007f9a521fc478 @capacity=50>
station.release_broken_bikes(van)
=> [#<Bike:0x007f9a5287c190 @broken=true>]
garage = Garage.new({capacity: 100})
=> #<Garage:0x007f9a5213a8c8 @capacity=100>
garage.accept_broken_bikes(van)
=> [#<Bike:0x007f9a5287c190 @broken=false>]
garage.bikes.count
=> 1
```

Collecting fixed bike from garage and delivering it to the docking station:

```ruby
garage.release_fixed_bikes(van)
=> [#<Bike:0x007f9a5287c190 @broken=false>]
station.accept_working_bikes(van)
=> [#<Bike:0x007f9a522d0e30 @broken=false>, #<Bike:0x007f9a5287c190 @broken=false>]
```

### Issues to be resolved
* Van duplicates functionality
