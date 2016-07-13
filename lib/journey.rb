class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :journey

  def initialize(station = nil)
    @journey = {}
    @journey[:entry] = station
  end

  def end_journey(station)
    @journey[:exit] = station
  end

  def journey_complete?
    !!journey[:entry] && !!journey[:exit]
  end

  def fare
    return MINIMUM_FARE if journey_complete?
    PENALTY_FARE
  end

end
