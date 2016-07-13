class Oystercard

  attr_accessor :balance
  attr_reader :current_journey, :journey_history

  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey_history = []
    @current_journey = {}
  end

  def top_up(amount)
    fail "card limit #{LIMIT} exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def in_journey?
    !!@current_journey[:entry]
  end

  def touch_in station
    message = "Insufficient balance. Minimum £#{MINIMUM_FARE} is required"
    fail message if @balance < MINIMUM_FARE
    @current_journey = {:entry => station}
  end

  def touch_out station
    deduct(MINIMUM_FARE)
    @current_journey[:exit] = station
    record_journey
  end

  def record_journey
    @journey_history << @current_journey
    @current_journey = {}
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
