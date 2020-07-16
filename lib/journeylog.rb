require_relative 'journey'

class JourneyLog

  def initialize(journey_class: Journey)
    @journey_class = journey_class
  end

  def start
    @journey = @journey_class.new
  end
end