class Oystercard

  attr_accessor :balance
  attr_accessor :entry_station
  attr_reader :exit_station, :journeys


  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "card limit #{LIMIT} exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in station
    fail "Insufficient balance. Minimum £#{MINIMUM_FARE} is required" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out station
    deduct(MINIMUM_FARE)
    self.entry_station = nil
    @exit_station = station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
