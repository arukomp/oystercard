require_relative 'journey'
class Oystercard
  MAX_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey, :history

  def initialize
     @balance = 0
     @journey = Journey.new
     @history = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_LIMIT} reached" if amount + balance > MAX_LIMIT
    @balance += amount
  end

  def in_journey?
    !journey.complete?
  end

  def touch_in(station = nil)
    fail "At least £#{MINIMUM_FARE} required" if balance < MINIMUM_FARE
    journey.start(station)
  end

  def touch_out(station = nil)
    journey.end(station)
    deduct(journey.fare)
    save_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def save_journey
    @history << journey
    @journey = Journey.new
  end

end
