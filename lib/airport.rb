class Airport

#constant value should be in caps
$max_capacity = 6

  def initialize
    @planes_at_airport =[]
    @capacity = $max_capacity
  end

  def receive_plane(plane)
    if planes_at_airport == @capacity then
      fail "Airport full"
    elsif whats_the_weather == :stormy then
      fail "Weathers bad can't land"
    else
      @planes_at_airport.push(plane)
      plane.land_plane
    end
  end

  def despatch_plane(plane)
    if whats_the_weather == :sunny then
      @planes_at_airport.delete(plane)
      plane.take_off_plane
    else
      fail "Weathers bad can't take off"
    end
  end

  def release_next()
    if @planes_at_airport.count == 0 then
      fail "No planes to take off"
    else
      @planes_at_airport.pop
    end
  end

  def planes_at_airport
    @planes_at_airport.count
  end

  #could have defined this as a module, weather is not really anything to do with airport. (many things can have weather,
  #if it was a module you could then include it in many things which were affected by weather )

  def whats_the_weather
    if rand(2) == 1 then
      :sunny
    else
      :stormy
    end
  end


end
