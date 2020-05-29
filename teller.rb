# frozen_string_literal: true

require 'byebug'

class Teller
  class InaccurateMoneyError < StandardError; end
  class IncompleteMoneyError < StandardError; end
  class FloatDenominationError < StandardError; end

  attr_accessor :denomination, :money, :money_left, :combinations, :result

  def self.make_change(opts)
    new(opts).send(:call)
  end

  def initialize(opts)
    self.denomination = opts.fetch(:denomination, [1])
    self.money = opts.fetch(:money, 1)
    self.money_left = money
    self.combinations = [nil] * (money + 1)
    self.result = []
    check_inaccurate_money
    check_denominations
  end

  private

  def call(**_opts)
    combinations_array
    results_array
    result
  end

  def combinations_array
    work = [[0, 0]]

    while combinations[money].nil? && !work.empty?
      base, starting_index = work.shift
      starting_index.upto(denomination.size - 1) do |index|
        coin = denomination[index]
        total = base + coin
        next unless total <= money && combinations[total].nil?
        combinations[total] = base
        work << [total, index]
      end
    end
  end

  def results_array
    check_incomplete_money
    while money_left.positive?
      array1 = combinations[money_left]
      result << money_left - array1
      self.money_left = array1
    end
  end

  def check_incomplete_money
    return unless combinations[money].nil?
    raise(
      IncompleteMoneyError,
      'Total must be a multiple of smaller denomination'
    )
  end

  def check_inaccurate_money
    return if money.positive?
    raise(InaccurateMoneyError, 'Money cannot be less that 0')
  end

  def check_denominations
    return unless (denomination.any? && denomination.min < 1) || (money < 1)
    raise(FloatDenominationError)
  end
end
