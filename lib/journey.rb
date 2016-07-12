class Journey
  MINIMUM_FARE = 1
  attr_reader :journey, :fare

  def initialize
    @journey = {}
    @fare = 0
  end

  def start(station)
    if @journey[:entry]
      @fare = 6
    end
    @journey[:entry] = station
  end

  def end(station)
    if !@journey[:entry]
      @fare = 6
    else
      @fare = MINIMUM_FARE
    end
    @journey[:exit] = station
  end

  def complete?
    (@journey[:entry] && @journey[:exit]) || @journey.empty?
  end

end
