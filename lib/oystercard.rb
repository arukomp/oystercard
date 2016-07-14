require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :balance, :journeys

  def initialize
    @balance = 0
    @journeys = []
    @journey = Journey.new
  end

  def top_up(amount)
    raise 'Maximum amount exceeded' if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @journey.in_journey?
  end

  def touch_in(station)
    fail "Sorry, insufficient funds" if balance < MIN_BALANCE
    @journey.begin(station)
  end

  def touch_out(station)
    @journey.finish(station)
    deduct(@journey.fare)
    @journeys << { "Entry Station:" => @journey.entry_station, "Exit station:" => @journey.exit_station }
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
