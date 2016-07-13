class Oystercard

  attr_accessor :balance
  attr_accessor :entry_station
  attr_reader :exit_station, :journey_history


  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey_history = []
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
    @current_journey = {:entry => station}
  end

  def touch_out station
    deduct(MINIMUM_FARE)

    @exit_station = station
    @current_journey[:exit] = station
    self.entry_station = nil
    @journey_history << @current_journey
    @current_journey = {}
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
