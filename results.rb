class Results
  attr_accessor :total_change, :denominations, :change

  def initialize(**opts)
    self.total_change = opts.fetch(:total_change)
    self.change = opts.fetch(:change)
    self.denominations = opts.fetch(:denominations)
  end

  def display_results
    puts "Change from: #{total_change}"
    puts "Using #{denominations}\n"
    puts "Change: #{change}"
  end

end
