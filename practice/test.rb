# 1問目
array = (1..64).to_a
def map_test(array)
  array.map do |a|
    a**4
  end
end
newArray = map_test(array)
p newArray.sum

sum = 0
for num in 1..64
  int = num ** 4
  sum = int + sum
end

# 2問目
require 'prime'

class Integer
  def my_divisor_list
    divisors = [1]
    primes = []
    Prime.prime_division(self).each do |prime|
      prime[1].times {primes << prime[0]}
    end

    1.upto(primes.size) do |i|
      primes.combination(i) do |prime|
        divisors << prime.inject{|a,b| a *= b}
      end
    end

    divisors.uniq!
    divisors.sort!
    return divisors
  rescue ZeroDivisionError
    return
  end

end

p 1234567890.my_divisor_list
array = [1, 2, 3, 5, 6, 9, 10, 15, 18, 30, 45, 90, 3607, 3803, 7214, 7606, 10821, 11409, 18035, 19015, 21642, 22818, 32463, 34227, 36070, 38030, 54105, 57045, 64926, 68454, 108210, 114090, 162315, 171135, 324630, 342270]
puts array.sum