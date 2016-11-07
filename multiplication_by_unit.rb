require 'bigdecimal'
require 'bigdecimal/util' # add method to_d
# require 'test/unit/assertions'

# # extend main object
# class << self
#   include Test::Unit::Assertions 
#   alias_method :aq, :assert_equal
# end

GLOBAL = binding

# eval and print
def ep(code, check = nil, comment = nil)
  evaled = GLOBAL.eval(code)

  unless check.nil?
    raise "oops for #{code}" if evaled != check
  end

  puts code 
  puts "=> #{GLOBAL.eval(code)} #{comment}"
  puts
end

puts

f = 64.4

# # assertions
# aq f, 64.4
# aq f.class, Float
# aq (1.to_d * f).class, BigDecimal
# aq f.to_d.class, (1.to_d * f).class

# aq f, 1.to_d * f

# assert_not_equal f.to_d, 1.to_d * f
# assert_not_equal f, f.to_d

# visualization

ep "f", f
ep "f.class", Float
ep "(1.to_d * f).class", BigDecimal
ep "f.to_d.class == (1.to_d * f).class", true

ep "f == 1.to_d * f", true
ep "f.to_d == 1.to_d * f.to_d", true

ep "f.to_d == 1.to_d * f", false, "<- WTF??"
ep "f == f.to_d", false, "<- WTF??"

ep "f.to_d" # => #<BigDecimal:7f8202038280,'0.644E2',18(36)>
ep "1.to_d * f" # => #<BigDecimal:7f82019c1208,'0.6440000000 000001E2',27(45)>

