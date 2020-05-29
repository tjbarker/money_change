class Result
  attr_accessor :total_change, :denominations, :change

  def self.display_results(**opts)
    new(opts).send(:call)
  end

  def initialize(total_change:, change:, denominations:)
    self.total_change = total_change
    self.change = change
    self.denominations = denominations
  end

  private

  def call
    puts "Change from: #{total_change}"
    puts "Using #{denominations}\n"
    puts "Change: #{change}"
  end
end
