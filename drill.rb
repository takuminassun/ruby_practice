# # odd? 奇数かどうか
# number = [1, 2, 3, 4, 5, 6, 7]
# puts number.count{ |x| x.odd? }
# # => 4

# # drop(n) 引数n個の要素取り除き、新しく配列作る 
# animals = ["mouse", "cow", "tiger", "rabbit", "dragon", "snake"]
# p animals.drop(2)
# # => ["tiger", "rabbit", "dragon", "snake"]

# # uniq 重複した要素を取り除き新しい配列
# p [1, 4, 1].uniq
# # => [1, 4]
# p [1, 3, 2, "2", "3"].uniq
# # => [1, 3, 2, "2", "3"]
# p [1, 3, 2, "2", "3"].uniq { |n| n.to_s }
# # => [1, 3, 2]

# # inject 繰り返しを行うメソッド
#   # 配列を全て足す記述
# array = 1..6
# puts array.inject { |sum, n| sum + n }

#   # 下記のeachと同じ
#   array = 1..6
#   sum = 0
#   array.each do |num|
#     sum += num
#   end
#   puts sum


# # scan マッチした部分文字列を返す
# def count_code(str)
#   puts str.scan(/a/).length
#   puts str.scan(/e/).length
# end
# count_code('caffelatte') # => 1
# # count_code('codexxcode') # => 2

# def end_other(a,b)
#   a_down = a.downcase # downcase 小文字に置き換えて返す
#   b_down = b.downcase
#   a_len = a_down.length
#   b_len = b_down.length
#   if  b_down.slice!(-(a_len)..b_len - 1) == a_down || a_down.slice!(-(b_len)..a_len - 1) == b_down
#     puts "True"
#   else
#     puts "False"
#   end
# end

# end_other('Hiabc', 'abc')

# def close_far(a, b, c)
#   if ((b - a).abs == 1 || (c - a).abs == 1 )
#     if ((b - c).abs >= 2)
#       puts "True"
#     else
#       puts "False"
#   else
#     puts "False"
#   end
# end

# close_far(1, 2, 10)
# close_far(1, 2, 3)
# close_far(4, 1, 3)

hash = {}
str = "caffellate"
#str = "hogehoge"
str.split('').each do |num|
  puts num
end
# puts str.scan(/c/).length
# puts str.scan(/a/).length
# puts str.scan(/f/).length
# puts str.scan(/e/).length
# puts str.scan(/l/).length
# puts str.scan(/t/).length
