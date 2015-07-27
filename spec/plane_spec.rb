require 'plane'

## Note these are just some guidelines!
## Feel free to write more tests!!

# When we create a new plane, it should have a "flying" status,
# thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should
# have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status
# should become "flying"

describe Plane do

  #unit tests, have one expect statement
  #only test plane, if you need anything else stub it out

  it 'has a flying status when created' do
    plane = Plane.new
    expect(plane.status).to eq(:flying)
  end

  it 'can land' do
    plane = Plane.new
    plane.land_plane
    expect(plane.status).to eq(:landed)
  end

  it 'can take off' do
    plane = Plane.new
    plane.land_plane
    plane.take_off_plane
    expect(plane.status).to eq(:flying)
  end

end
