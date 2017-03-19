# checked for ruby-version 2.4.0

####
# This script shows that ruby conversion of Float into Decimal is somehow inconsistent;
# One would reasonably expect the equality 1.to_d * f == f.t_d to hold for every Float value f,
# i.e. multiplying by DigDecimal unit can be viewed as alternative way of casting Float into Decimal.
# Yet for some Floats (e.g. 64.4) the results differ, as showed in this script.

# My original question on stackoverflow:
# http://stackoverflow.com/questions/40472933/inconsistent-conversion-of-float-into-decimal-in-ruby/40473007

# As Stefan points out in his exhaustive answer, it is due to different precisions being used:
# 64.4.to_d is equivalent to BigDecimal(64.4, Float::DIG)
# while
# 1.to_d * 64.4 translates to BigDecimal(64.4, Float::DIG + 1)

require 'bigdecimal'
require 'bigdecimal/util' # add method to_d

GLOBAL = binding # scoping trick

# eval the code and print the code and it's result
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

# precision check:
# http://stackoverflow.com/questions/40472933/inconsistent-conversion-of-float-into-decimal-in-ruby/40473007
ep "f.to_d(16) == 1.to_d * f", true
ep "f.to_d == 1.to_d.mult(f, 15)", true

