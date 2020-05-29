# frozen_string_literal: true

require_relative '../result.rb'

describe Result do
  let(:total_change) { 0 }
  let(:denominations) { [1, 2, 3, 4] }
  let(:change) { [1, 2, 3] }

  describe 'make_change' do
    subject do
      Result.display_results(
        total_change: total_change,
        denominations: denominations,
        change: change
      )
    end

    context 'when decimals are used' do
      let(:expected_string) do
        "Change from: #{total_change}\n"\
          "Using #{denominations}\n"\
          "Change: #{change}\n"
      end

      it { expect { subject }.to output(expected_string).to_stdout }
    end
  end
end
