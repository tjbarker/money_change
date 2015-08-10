class Setup
  attr_accessor :i, :denominations, :response


  def get_total_change
    puts 'what is the total change to be given?'
    gets.chomp.to_i.tap do |total_change|
      fail(StandardError, 'Total change must be greater than zero') unless (total_change > 0)
    end
  end

  def get_denomination
    set_up_get_denomination
    while i == false do
      ask_question
      if response == 'n'
        self.i = true
      else
        input_denomination
      end
      puts denominations.inspect
    end
    denominations
  end

  private

  def set_up_get_denomination
    self.i = false
    self.denominations = []
  end

  def ask_question
    puts "What is one of the possible denominations? (type 'n' when finished)"
    self.response = gets.chomp
  end

  def input_denomination
    self.response = response.to_i
    response.tap do |denomination|
      fail(StandardError, 'All denominations must be greater than zero') unless (denomination > 0)
    end
    self.denominations << response
  end
end
