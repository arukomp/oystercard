class Journey

  attr_reader :journey

  def initialize(station)
    @journey = {:entry => station}
  end

  def end_journey(station)
    @journey = {:exit => station}
  end

  def journey_complete?
    !!@journey[:exit]
  end

end
