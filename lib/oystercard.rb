class Oystercard
  attr_accessor :balance
  LIMIT = 90
  def initialize
    @balance = 0
  end
  def top_up(amount)
    fail "card limit #{LIMIT} exceeded" if @balance + amount > LIMIT
    @balance += amount

  end

end
