require 'airport'

## Note these are just some guidelines!
## Feel free to write more tests!!

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport
# and how that is implemented.
#
# If the airport is full then no planes can land

########### TO RUN JUST THIS FILE ###############
# rspec ./spec/airport_spec.rb
#################################################

describe Airport do

  #stub out random behaviour
  #stub out apis (non in this example)
  #as these are airport unit tests stub out anything about planes

  #this is done before each test to create an airport
  let(:airport2){Airport.new}

  context 'taking off and landing' do

    it {is_expected.to respond_to(:receive_plane).with(1).argument}

    it 'a plane can land at the airport' do
      plane = double(:plane)
      allow(plane).to receive(:land_plane).and_return(true)
      ap = Airport.new
      #stub random behaviour to test, the below line added to all tests to stub weather.
      allow(ap).to receive(:whats_the_weather).and_return(:sunny)
      ap.receive_plane(plane)
      expect(ap.planes_at_airport).to eq(1)
    end

    it 'a plane can take off at the airport' do
      # create a double
      plane = double(:plane)
      # create a stub, this replaces the plane method
      allow(plane).to receive(:land_plane).and_return(true)
      allow(plane).to receive(:take_off_plane).and_return(true)
      ap = Airport.new
      allow(ap).to receive(:whats_the_weather).and_return(:sunny)
      ap.receive_plane(plane)
      ap.despatch_plane(plane)
      expect(ap.planes_at_airport).to eq(0)
    end

    it 'a plane cannot take off if there are no planes' do
      # this test uses the airport created 'before' rest of tests don't use this.
      expect{airport2.release_next}.to raise_error "No planes to take off"
    end

  end

  context 'traffic control' do

    it 'an airport can receive 6 planes' do
      plane = double(:plane)
      allow(plane).to receive(:land_plane).and_return(true)
      ap = Airport.new
      allow(ap).to receive(:whats_the_weather).and_return(:sunny)
      6.times { ap.receive_plane(plane) }
      expect(ap.planes_at_airport).to eq(6)
    end

    it 'a plane cannot land if the airport is full' do
      plane = double(:plane)
      allow(plane).to receive(:land_plane).and_return(true)
      ap = Airport.new
      allow(ap).to receive(:whats_the_weather).and_return(:sunny)
      $max_capacity.times { ap.receive_plane(plane) }
      expect{ap.receive_plane(plane)}.to raise_error "Airport full"
      expect(ap.planes_at_airport).to eq($max_capacity)
    end

  end

  context 'weather conditions' do
    # Include a weather condition.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy,
    # the plane can not take off and must remain in the airport.
    #
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport

    it 'a plane cannot take off when there is a storm brewing' do
      plane = double(:plane)
      allow(plane).to receive(:land_plane).and_return(true)
      ap = Airport.new
      allow(ap).to receive(:whats_the_weather).and_return(:sunny)
      ap.receive_plane(plane)
      allow(ap).to receive(:whats_the_weather).and_return(:stormy)
      expect{ap.despatch_plane(plane)}.to raise_error "Weathers bad can't take off"
    end


    it 'a plane cannot land when there is a storm brewing' do
      plane = double(:plane)
      ap = Airport.new
      allow(ap).to receive(:whats_the_weather).and_return(:stormy)
      expect{ap.receive_plane(plane)}.to raise_error "Weathers bad can't land"
    end

  end

end
