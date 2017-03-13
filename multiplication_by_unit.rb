# checked for ruby-version 2.4.0

require 'bigdecimal'
require 'bigdecimal/util' # add method to_d

GLOBAL = binding

# eval and print
def ep(code, check = nil, comment = nil)
  evaled = GLOBAL.eval(code)

  unless check.nil?
    raise "oops for #{code}" if evaled != check
  end

  puts code 
  puts "=> #{evaled} #{comment}"
  puts
end

puts

strange_values =  [64.4, 73.60, 77.90, 87.40, 95.40]

f = strange_values.sample

# visualization

ep "f", f
ep "f.class", Float
ep "(1.to_d * f).class", BigDecimal
ep "f.to_d.class == (1.to_d * f).class", true

ep "f == 1.to_d * f", true
ep "f.to_d == 1.to_d * f.to_d", true

ep "f.to_d == 1.to_d * f", false, "<- WTF??"
ep "f == f.to_d", false, "<- WTF??"

# sanity check
ep "f * 1.to_d == 1.to_d * f", true

ep "f.to_d" # => #<BigDecimal:7f8202038280,'0.644E2',18(36)>
ep "1.to_d * f" # => #<BigDecimal:7f82019c1208,'0.6440000000 000001E2',27(45)>

