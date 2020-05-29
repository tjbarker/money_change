# frozen_string_literal: true

require_relative '../teller.rb'

describe Teller do
  let(:money) { 0 }
  let(:denomination) { [] }

  subject do
    Teller.make_change(money: money, denomination: denomination)
  end

  describe 'make_change' do
    context 'when given money given is < 0' do
      let(:money) { -1 }
      it 'raises an error' do
        expect { subject }.to raise_error(Teller::InaccurateMoneyError)
      end
    end

    context 'when given money that is perfect to denomination' do
      let(:money) { 3 }
      let(:denomination) { [money, 2, 1] }
      it { expect(subject).to eq([money]) }
    end

    context 'when given money that is perfect to 2 largest' do
      let(:unit) { 3 }
      let(:money) { unit * 2 }
      let(:denomination) { [unit, 2, 1] }
      it { expect(subject).to eq([unit, unit]) }
    end

    context 'when given money that is for each denomination' do
      let(:money) { denomination.sum }
      let(:denomination) { [3, 2] }
      it { expect(subject).to match_array([3, 2]) }
    end

    context 'when greedy will not work' do
      let(:money) { 11 }
      let(:denomination) { [7, 5, 1] }
      it { expect(subject).to match_array([5, 5, 1]) } # as opposed to [7, 1, 1, 1, 1] by greedy
    end

    context 'when given money that is unsplittable for denomination' do
      let(:money) { 13 }
      let(:denomination) { [7, 4] }
      it { expect { subject }.to raise_error(Teller::IncompleteMoneyError) }
    end

    context 'when decimals are used' do
      let(:money) { 1.4 }
      let(:denomination) { [1, 0.2] }
      it { expect { subject }.to raise_error(Teller::FloatDenominationError) }
    end
  end
end
