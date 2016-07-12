class Oystercard

  attr_accessor :in_journey
  attr_accessor :balance
  attr_accessor :entry_station

  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "card limit #{LIMIT} exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def in_journey?
    in_journey
  end

  def touch_in station
    fail "Insufficient balance. Minimum £#{MINIMUM_FARE} is required" if @balance < MINIMUM_FARE
    @entry_station = station
    self.in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    self.in_journey = false
    self.entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
