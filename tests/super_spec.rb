# frozen_string_literal: true

require_relative '../super.rb'

describe do
  subject { Super.call }

  let(:total_change) { double(:total_change) }
  let(:denominations) { double(:denominations) }
  let(:teller) { double(:teller) }
  let(:change) { double(:change) }
  let(:result) { double(:result) }
  let(:setup) do
    double(:setup,
           get_total_change: total_change,
           get_denomination: denominations)
  end

  before do
    allow(Setup).to receive(:new) { setup }
    allow(Teller).to receive(:make_change).with(
      money: total_change,
      denomination: denominations
    ) { change }

  end

  it 'calls the correct flows' do
    expect(Result).to receive(:display_results).with(
      total_change: total_change,
      denominations: denominations,
      change: change
    )
    subject
  end
end
