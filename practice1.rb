h = { 1 => "value"}
# 生成されたハッシュのデフォルト値はnil
h.default = 'none' # デフォルト値をnoneに変更

g = Hash[h]
# p g　 #=> {1=>"value"}


# hに key = :add, value = someのハッシュを追加
h[:add] = 'some'
# p h  # => {1=>"value", :add=>"some"}

# key = 1のvalueにplusを追加
h[1] << 'plus' #破壊的操作
# p h  # => {1=>"valueplus", :add=>"some"}
# p g


ary = [1,"a", 2,"b", 3, ["c"]]
# p ary  # => [1, "a", 2, "b", 3, ["c"]]

# 配列からハッシュへ
# self[*key_and_value] -> Hash
# p Hash[*ary] # => {1=>"a", 2=>"b", 3=>["c"]}

# キーと値のペアの配列からハッシュへ
alist = [[1,"a"], [2,"b"], [3,["c"]]]
# p alist # => [[1, "a"], [2, "b"], [3, ["c"]]]
# p alist.flatten
# p Hash[*alist.flatten] # => {1=>"a", 2=>"b", 3=>"c"}

# キーと値の配列のペアからハッシュへ
keys = [1, 2, 3]
vals = ["a", "b", ["c"]]
alist = keys.zip(vals)
# p alist # => [[1, "a"], [2, "b"], [3, ["c"]]]
# p Hash[alist]

# キーや値が配列の場合
alist = [[1,["a"]], [2,["b"]], [3,["c"]], [[4,5], ["a", "b"]]]
# p Hash[alist]


# new(ifnone = nil) -> Hash

# 空の新しいハッシュを生成
h = Hash.new([])
# デフォルト値の設定
h[0] << 0
h[1] << 1
# p h.default #=> [0, 1]
# p h #=> {}

h = Hash.new([])
# p h[1] #=> []
# p h[1].object_id #=> 60
# p h[1] << "bar" #=> ["bar"]
# p h[1] #=> ["bar"]
# p h[2] #=> ["bar"]
# p h[2].object_id #=> 60
# p h #=> {}

h = Hash.new([].freeze)
# #破壊的でないメソッドはOK
p h[0] += [0] #=> [0]

p h[1] << 1 #=> can't modify frozen Array: [] (FrozenError)