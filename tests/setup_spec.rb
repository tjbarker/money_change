# frozen_string_literal: true

require_relative '../setup.rb'

describe Setup do
  let(:setup) { Setup.new }

  describe 'get_total_change' do
    subject { setup.get_total_change }

    context 'when positive number given' do
      it 'returns the list until n is passed in' do
        allow_any_instance_of(Object).to receive(:gets).and_return('11')
        expect { subject }.to output(
          "what is the total change to be given?\n"
        ).to_stdout
        expect(subject).to eq(11)
      end
    end

    context 'when letter given' do
      it 'fails' do
        allow_any_instance_of(Object).to receive(:gets).and_return('a')
        allow_any_instance_of(Object).to receive(:puts).and_return(nil)
        expect { subject }.to raise_error(Setup::IncorrectTotalError)
      end
    end

    context 'when negative number given' do
      it 'returns the list until n is passed in' do
        allow_any_instance_of(Object).to receive(:gets).and_return('-1')
        allow_any_instance_of(Object).to receive(:puts).and_return(nil)
        expect { subject }.to raise_error(Setup::IncorrectTotalError)
      end
    end
  end

  describe 'get_denomination' do
    subject { setup.get_denomination }

    it 'returns the list until n is passed in' do
      allow_any_instance_of(Object).to receive(:gets).and_return(
        '1', '2', '3', 'n'
      )

      expect { subject }.to output(
        "What is one of the possible denominations? (type 'n' when finished)\n"\
        "[1]\n"\
        "What is one of the possible denominations? (type 'n' when finished)\n"\
        "[1, 2]\n"\
        "What is one of the possible denominations? (type 'n' when finished)\n"\
        "[1, 2, 3]\n"\
        "What is one of the possible denominations? (type 'n' when finished)\n"\
        "[1, 2, 3]\n"
      ).to_stdout
      expect(subject).to eq([1, 2, 3])
    end
  end
end
