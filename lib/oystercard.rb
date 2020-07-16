require_relative 'journey'

class OysterCard
  attr_reader :balance, :journey_history, :current_journey

  CARD_LIMIT = 90
  MINIMUM_BALANCE = Journey::MINIMUM_FARE

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "card limit: #{CARD_LIMIT} reached" if amount + @balance > CARD_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    deduct(@current_journey.fare) if in_journey? == true
    raise "Insufficient balance" if @balance < MINIMUM_BALANCE
    @current_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    @current_journey = Journey.new() if in_journey? == false
    @current_journey.end_journey(exit_station)
    deduct(@current_journey.fare)
    save_history
  end

  def save_history
    @journey_history << @current_journey
    @current_journey = nil
  end

  def in_journey?
    @current_journey != nil ? true : false
  end

  private
  
  def deduct(amount)
    @balance -= amount
  end
end
