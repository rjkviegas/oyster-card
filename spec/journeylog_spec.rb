require 'journeylog.rb'

describe JourneyLog do
   
  describe '#start' do
      it 'creates a journey' do
          expect(subject.start).to be_an_instance_of(Journey)
      end
  end


end