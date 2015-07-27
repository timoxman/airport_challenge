class Plane

  def initialize
    @status = :flying
  end

  def status
    @status
  end

  def land_plane
    @status = :landed
    true
  end

  def take_off_plane
    @status = :flying
    true
  end

end
