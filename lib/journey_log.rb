require_relative 'journey'

class JourneyLog

  attr_reader :journey, :journey_class

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
    @journey = journey_class.new
  end

  def start(station)
    # @journey = journey_class.new(station)
    current_journey.start_journey(station)
  end

  def finish(station)
    @journeys << { entry: @journey.journey[:entry], exit: station }
    current_journey.end_journey(station)
  end

  def journeys
    @journeys.clone
  end

  private

  def current_journey
    @journey = journey_class.new if @journey.journey_complete?
    @journey
  end

end
