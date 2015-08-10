class Teller
  attr_accessor :denomination, :money, :money_left, :multiplier_used, :combinations, :result,

  def initialize
    self.denomination = []
    self.money = 0
    self.money_left = 0
    self.multiplier_used = false
    self.combinations = []
    self.result = []
  end

  def make_change(**opts)
    self.denomination = opts.fetch(:denomination,[1])
    self.money = opts.fetch(:money,1)
    self.money_left = money
    fail(StandardError, 'Money cannot be less that 0') if (money < 0)
    multiply_out_decimals
    combinations_array
    results_array
    divide_back_to_decimals
    result
  end

  private

  def multiply_out_decimals
    if denomination.min < 1
      decimal_point = 0
      denomination_minimum = denomination.min
      while(denomination.min != denomination.min.to_i)
        decimal_point += 1
        denomination_minimum *= 10
      end
      self.denomination.map! { |item| item  * (10 ** decimal_point)}
      self.money *= (10 ** decimal_point)
      self.multiplier_used = true
    end
    fail(StandardError, 'Total must be a multiple of smaller denomination') if (money % denomination.min != 0)
  end


  def combinations_array
    self.combinations = [money + 1]
    work = [[0, 0]]

    while combinations[money].nil? && !work.empty? do
      base, starting_index = work.shift
      starting_index.upto(denomination.size - 1) do |index|
        coin = denomination[index]
        total = base + coin
        if total <= money && combinations[total].nil?
          self.combinations[total] = base
          work << [total, index]
        end
      end
    end
  end

  def results_array
    return nil if combinations[money].nil?
    self.result = []
    while money_left > 0 do
      array1 = combinations[money_left]
      self.result << money_left - array1
      self.money_left = array1
    end
  end

  def divide_back_to_decimals
    if multiplier_used == true
      self.result.map! { |item| item /(10 ** decimal_point)}
    end
  end
end
