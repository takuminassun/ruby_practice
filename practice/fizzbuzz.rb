# each メソッド

# (1..30).each do |num|
#   if num % 15 == 0
#     puts "FizzBuzz"
#   elsif num % 3 == 0
#     puts "Fizz"
#   elsif num % 5 == 0
#     puts "Buzz"
#   else
#     puts num
#   end
# end


# upto メソッド

# 1.upto(30) do |i|
#   if i % 15 == 0
#     puts "FizzBuzz"
#   elsif i % 3 == 0
#     puts "Fizz"
#   elsif i % 5 == 0
#     puts "Buzz"
#   else
#     puts i
#   end
# end


# times メソッド

# 31.times do |i|
#   if i == 0
    
#   elsif i % 15 == 0
#     puts "FizzBuzz"
#   elsif i % 3 == 0
#     puts "Fizz"
#   elsif i % 5 == 0
#     puts "Buzz"
#   else
#     puts i
#   end
# end


# フィボナッチ数列


# def fibo(n)
#   array_fibonatti = Array.new
#   array_fibonatti[0] = array_fibonatti[1] = 1
#   for i in 2..n
#     tmp = array_fibonatti[i - 1] + array_fibonatti[i - 2]
#     array_fibonatti.push(tmp)
#   end
#   # 結果を表示
#   puts array_fibonatti
# end

# num = gets.to_i
# fibo(num)


def fib(n)
  f = []
  puts f[0] = f[1] = 1
  if n >= 2
    (2..n).each do |i|
      f[i] = f[i-1] + f[i-2]
      puts f[i] 
    end
  end
end

num = gets.to_i
fib(num)