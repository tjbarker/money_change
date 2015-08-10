require 'byebug'

class Teller
  def make_change(money, denomination = [])
    multiplier_used = false

    fail(StandardError, 'Money cannot be less that 0') if (money < 0)

#    if (denomination.min <= 0)
#      puts 'negative denominations values have been removed'
#      denomination.delete_if { |coin| coin <= 0}
#    end

    if denomination.min < 1
      decimal_point = 0
      denomination_minimum = denomination.min
      while(denomination_minimum != denomination_minimum.to_i)
        decimal_point += 1
        denomination_minimum *= 10
      end
      denomination.map! { |item| item  *(10 ** decimal_point)}
      money *= (10 ** decimal_point)
      multiplier_used = true
    end

    fail(StandardError, 'Total must be a multiple of smaller denomination') if (money % denomination.min != 0)

    combinations = [money + 1]
    work = [[0, 0]]
    while combinations[money].nil? && !work.empty? do
      base, starting_index = work.shift
      starting_index.upto(denomination.size - 1) do |index|
        coin = denomination[index]
        total = base + coin
        if total <= money && combinations[total].nil?
          combinations[total] = base
          work << [total, index]
        end
      end
    end
    money_left = money
    return nil if combinations[money].nil?
    result = []
    while money_left > 0 do
      array1 = combinations[money_left]
      result << money_left - array1
      money_left = array1
    end

    if multiplier_used == true
      result.map! { |item| item /(10 ** decimal_point)}
    end

    puts "change from #{money}:"
    puts "#{result}"
  end
end

coins = Teller.new
