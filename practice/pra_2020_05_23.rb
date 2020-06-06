#4
# y = false
# y && (raise "falsed")
# puts("succeeded!") # => succeeded!

#6
# HOGE = "hoge"
# HOGE.gsub!("hoge", "piyo")
# print HOGE
# # gsub 文字列中で pattern にマッチする部分全てを文字列 replace で置き換えた文字列を生成して返します

#8
# begin
#   puts 10 / 0 
# rescue ZeroDivisionError => ex
#   print "ZeroDivisionError:", ex.message
# end

#9
# p ?A # => "A"

#13
# p "12abc".to_i # => 12

#14
# a=[1,2,3,4]
# p a[1...3] # => [2, 3]

#15
# a=[1,2,3,4,5]
# p a[2..-1] # => [3, 4]

#16
# a = 1,2,3
# p a.join(",") # => "1,2,3"

#17
# s = "a;b:c;d:e;f"
# p s.split(/:|;/) # => ["a", "b", "c", "d", "e", "f"]

#19
# a=[1,2,3,4]
# b=[1,3,5,7]
# p a || b # => [1, 2, 3, 4]
# ||演算子　左オペランドの結果が真なら左を返す

#21
# a=[1,2,3]
# b=[1,3,5]
# c=[2,3,4]
# p a + b - c # => [1, 1, 5]

#22
# delet_ifとreject!は同じ動作
# 真になった要素を削除

#25
# a = [:a,:a,:b,:c]
# a[5]=:e
# a.concat([:a,:b,:c])
# a.compact
# a.uniq
# p a # => [:a, :a, :b, :c, nil, :e, :a, :b, :c]