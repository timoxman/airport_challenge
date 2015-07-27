require 'capybara/rspec'

## Note these are just some guidelines!
## Feel free to write more tests!!

# As a pilot
# So that I can arrive at my specified destination
# I would like to land my plane at the appropriate airport

feature 'Planes can land at airports' do
  scenario 'A plane arrives at the airport and can land' do
    ap = Airport.new
    allow(ap).to receive(:whats_the_weather).and_return(:sunny)
    boeing = Plane.new
    ap.receive_plane(boeing)
    expect(ap.planes_at_airport).to eq(1)
    expect(boeing.status).to eq :landed
  end
end


# As a pilot
# So that I can set off for my specified destination
# I would like to be able to take off from the appropriate airport

feature 'Planes can take off from the airport' do
  scenario 'given a plane at the airport it can take off' do
    ap = Airport.new
    allow(ap).to receive(:whats_the_weather).and_return(:sunny)
    boeing = Plane.new
    ap.receive_plane(boeing)
    ap.despatch_plane(boeing)
    expect(ap.planes_at_airport).to eq(0)
    expect(boeing.status).to eq :flying
  end
end

# Given 6 planes, each plane must land.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have status "landed"
# Once all planes are in the air again, check that they have status "flying!"

# As an air traffic controller
# So that I can avoid collisions
# I want to be able to prevent airplanes landing when the airport if full

feature 'the airport has a capacity, which may stop a plane from landing' do
  scenario 'try to land plane at full airport' do
    ap = Airport.new
    allow(ap).to receive(:whats_the_weather).and_return(:sunny)
    boeing = Plane.new
    airbus = Plane.new
    piper = Plane.new
    jetstream = Plane.new
    bombardier = Plane.new
    embraer = Plane.new
    hawker = Plane.new
    ap.receive_plane(boeing)
    ap.receive_plane(airbus)
    ap.receive_plane(piper)
    ap.receive_plane(jetstream)
    ap.receive_plane(embraer)
    ap.receive_plane(hawker)
    expect { ap.receive_plane(bombardier) }.to raise_error "Airport full"
    expect(ap.planes_at_airport).to eq(6)
    expect(bombardier.status).to eq :flying
    expect(boeing.status).to eq :landed
  end
end


# As an air traffic controller
# So that I can avoid accidents
# I want to be able to prevent airplanes landing when the weather is stormy

feature 'The ability to land the plane is affected by the weather at the airport' do
  scenario 'try to land plane at an airport with weather' do
    ap = Airport.new
    allow(ap).to receive(:whats_the_weather).and_return(:stormy)
    boeing = Plane.new
    expect { ap.receive_plane(boeing) }.to raise_error "Weathers bad can't land"
    expect(ap.planes_at_airport).to eq(0)
    expect(boeing.status).to eq :flying
  end
end
