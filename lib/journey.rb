class Journey

  attr_reader :current_journey

  def initialize
    @current_journey = {}
  end

  def start_journey(station)
    @current_journey = {:entry => station}
  end

  def end_journey(station)
    @current_journey = {:exit => station}
  end

  # def in_journey?
  #   !!@current_journey[:entry]
  # end



end
