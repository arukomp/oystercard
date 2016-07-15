require_relative 'station'
require_relative 'journey'

class Oystercard

  LIMIT = 90

  attr_reader :balance, :current_journey, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    fail "card limit #{LIMIT} exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(station)
    message = "Insufficient balance. Minimum £#{Journey::MINIMUM_FARE} is required"
    fail message if @balance < Journey::MINIMUM_FARE
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    @current_journey.end_journey(station)
    deduct(current_journey.fare)
    record_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def record_journey
    @journey_history << @current_journey
  end
end
