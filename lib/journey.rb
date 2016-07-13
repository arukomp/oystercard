class Journey

  attr_reader :journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(station)
    @journey = {:entry => station}
  end

  def end_journey(station)
    @journey = {:exit => station}
  end

  def journey_complete?
    !!@journey[:exit]
  end

  def fare
    return MINIMUM_FARE if journey_complete?
    PENALTY_FARE
  end

end
