class JourneyLog

  attr_reader :journey

  def initialize
    # @current_journey = {}
  end

  def start(station)
    @journey = Journey.new(station)
  end

  def finish(station)
    @journey.end_journey(station)
  end

  def journeys
    #returns protected array of journey history
  end

  def current_journey
    #incomplete_journey || Journey.new
  end

end
