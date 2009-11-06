require 'show_me_the_money'

# yeah, this is not a real test
["0.11", "1.44", "213.12", "1234.56", "123.22", "45353.33", "2209.12", "3323.00",
"232445.88", "566321.00", "90300.00",
"1134299.17", "2998877.11", "2998877.12", "12998877.12", "343526879.02"].each do |amount|
  arr = amount.split(".")
  kune, lipe = arr[0].to_i, arr[1].to_i
  puts amount.to_s + " --> " + ShowMeTheMoney.new.kune_in_words(kune, lipe)
end

