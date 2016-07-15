require_relative 'journey'

class JourneyLog

  attr_reader :journey, :journey_class

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
    @journey = journey_class.new
  end

  def start(station)
    @journey = journey_class.new(station)
  end

  def finish(station)
    @journey.end_journey(station)
    @journeys << journey.journey
  end

  def current_journey
    return journey_class.new if @journey.journey_complete?
    @journey
  end

  def journeys
    @journeys.clone
  end

end
