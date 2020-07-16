require 'journey.rb'

describe Journey do

let(:entry_station) { double(:entry_station) }
let(:exit_station) { double(:exit_station) }

  describe '#initialize' do
    it 'stores entry station' do
      journey = Journey.new(entry_station)
      expect(journey.entry_station).to eq entry_station
    end

  describe '#end_journey'
    it 'stores exit station' do
      journey = Journey.new(entry_station)
      journey.end_journey(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

  describe '#journey_complete?' do
    it 'is the journey complete, returns false' do
      journey = Journey.new(entry_station)
      expect(journey.complete?).to be false
    end

    it 'is the journey complete, returns true' do
      journey = Journey.new(entry_station)
      journey.end_journey(exit_station)
      expect(journey.complete?).to be true
    end
  end

  describe '#fare' do
    it 'returns penalty fare of 6, if no entry or exit' do
      journey = Journey.new(entry_station)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it 'returns minimum fare of 1, when there is both and entry and exit' do
      journey = Journey.new(entry_station)
      journey.end_journey(exit_station)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end
  end
end
