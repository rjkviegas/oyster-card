class Station
  attr_reader :info
  def initialize(name, zone)
    @info = {:name => name, :zone => zone}
  end
end
