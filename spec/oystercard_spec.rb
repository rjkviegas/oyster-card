require 'oystercard'

describe OysterCard do

  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }


  describe '#initialize' do
    it 'is initialized with a balance of 0' do
      expect(subject.balance).to eq(0)
    end

    it 'is initialized with an empty journey_history array' do
      expect(subject.journey_history).to eq([])
    end
  end

  describe '#top_up(amount)' do
    it 'top up card with amount' do
      expect(subject.top_up(OysterCard::CARD_LIMIT)).to eq(OysterCard::CARD_LIMIT)
    end

    it 'prevents top up if limit exceeded' do
      subject.top_up(OysterCard::MINIMUM_BALANCE)
      expect { subject.top_up(OysterCard::CARD_LIMIT)}.to raise_error("card limit: #{OysterCard::CARD_LIMIT} reached")
    end
  end

  describe '#touch_in' do
    it 'allows a card to register the start of a journey' do
      subject.top_up(OysterCard::CARD_LIMIT)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to be true
    end

    it 'throws error if card with insufficient balance is touched in' do
      expect { subject.touch_in(entry_station) }.to raise_error("Insufficient balance")
    end

    it 'expect card to remember entry station' do
      entry_station = double(:entry_station)
      subject.top_up(OysterCard::CARD_LIMIT)
      subject.touch_in(entry_station)
      expect(subject.current_journey.entry_station).to eq entry_station
    end

    it 'touch in touch in, penalty fare' do
      subject.top_up(OysterCard::CARD_LIMIT)
      subject.touch_in(entry_station)
      expect { subject.touch_in(entry_station) }.to change{ subject.balance }.by(-Journey::PENALTY_FARE)

    end
  end

  describe '#touch_out' do
    it 'allows a card to register the end of a journey' do
      subject.top_up(OysterCard::CARD_LIMIT)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to be false
    end

    it 'check charge is made on touch out' do
      subject.top_up(OysterCard::CARD_LIMIT)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-OysterCard::MINIMUM_BALANCE)
    end

    it 'touch out without touching in' do
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Journey::PENALTY_FARE)
    end

    it 'touch out touch out' do
      subject.touch_out(exit_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Journey::PENALTY_FARE)
    end
  end

  describe '#in_journey?' do
    it 'marks a card as in journey' do
      subject.top_up(OysterCard::CARD_LIMIT)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to be true
    end

    it 'marks a card as not in journey' do
      expect(subject.in_journey?).to be false
    end
  end

  describe '#journey_history' do
    it 'checking touching in and out creates one journey' do
      subject.top_up(OysterCard::CARD_LIMIT)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history.count).to eq 1
    end
  end


end
