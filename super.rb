# frozen_string_literal: true

require_relative 'setup'
require_relative 'teller'
require_relative 'result'

class Super
  def self.call
    new.send(:call)
  end

  def setup
    @setup ||= Setup.new
  end

  def call
    Result.display_results(
      total_change: total_change,
      denominations: denominations,
      change: change
    )
  end

  def total_change
    @total_change ||= setup.get_total_change
  end

  def denominations
    @denominations ||= setup.get_denomination
  end

  def change
    @change ||= Teller.make_change(
      money: total_change,
      denomination: denominations
    )
  end
end
