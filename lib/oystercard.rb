
class Oystercard
  MAX_LIMIT = 90
  MINIMUM_FARE = 1

  attr_accessor :balance
  attr_reader :entry_station

  def initialize
     @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_LIMIT} reached" if amount + balance > MAX_LIMIT
    self.balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station= nil)
    fail "At least £#{MINIMUM_FARE} required" if balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

  def deduct(amount)
    self.balance -= amount
  end

end
