require 'journeylog.rb'
describe JourneyLog do

  let(:journey) {double(:journey, end_journey: station)}
  let(:station) {double(:station)}
  let(:journey_class) {double(:journey_class, new: journey)}
  subject {described_class.new(journey_class)}
   
  describe '#start' do
    it 'starts a journey' do
        expect(journey_class).to receive(:new).with(entry_station: station)
        subject.start(entry_station: station)
      end

    it 'records a journey' do
        subject.start(station)
        expect(subject.journeys).to include(journey)
      end
    end

  describe '#finish' do

     it 'adds an exit station to the current journey' do
      subject.start(station)
      expect(journey).to receive(:end_journey).with(exit_station: station) 
      subject.finish(exit_station: station)
     end

     it 'records a journey' do
      subject.finish(station)
      expect(subject.journeys).to include(journey)
    end

    it 'current journey recorded once upon completion' do
      subject.start(station)
      subject.finish(station)
      expect(subject.journeys.count).to eq 1
    end
  end

  describe '#journeys' do

      it 'returns a list of journeys' do
        expect(subject.journeys).to be_an(Array)
      end

      it 'does not allow the original array to be altered' do
        subject.start(station)
        subject.journeys.pop
        expect(subject.journeys.count).to eq 1
      end
    end

end