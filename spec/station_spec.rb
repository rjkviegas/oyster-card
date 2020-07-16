require './lib/station.rb'

describe Station do
  describe '#initialize' do

    subject { Station.new("Liverpool Street",1) }

    it 'has a name' do
      expect(subject.info[:name]).to eq("Liverpool Street")
    end
    it 'has a zone' do
      expect(subject.info[:zone]).to eq(1)
    end
  end
end
