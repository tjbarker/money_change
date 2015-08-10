require_relative 'setup'
require_relative 'change'
require_relative 'results'

setup = Setup.new
total_change = setup.get_total_change
denomination = setup.get_denomination

teller = Teller.new.make_change(money: total_change, denomination: denomination)

results = Results.new(total_change: total_change, denominations: denomination, change: teller).display_results
