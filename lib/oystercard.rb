
class Oystercard
  MAX_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey, :history

  def initialize
     @balance = 0
     @journey = {}
     @history = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_LIMIT} reached" if amount + balance > MAX_LIMIT
    @balance += amount
  end

  def in_journey?
    !!journey[:entry]
  end

  def touch_in(station = nil)
    fail "At least £#{MINIMUM_FARE} required" if balance < MINIMUM_FARE
    @journey[:entry] = station
  end

  def touch_out(station = nil)
    deduct(MINIMUM_FARE)
    @journey[:exit] = station
    save_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def save_journey
    @history << journey
    @journey = Hash.new
  end

end
