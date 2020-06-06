require './explanation'
require './turn'
require './choice'
require './wise_man'

$line = p "------------------------------------------"
xeno = [10,9,8,8,7,7,6,6,5,5,4,4,3,3,2,2,1,1].shuffle

#自分の手札カード
myhand = [xeno.delete_at(0)]

#相手の手札カード
pchand = [xeno.delete_at(0)]

#山札の一番下にあるヒーローカード
hero = xeno.delete_at(0)

#自分の使用済みカード
mydiscard = []

#相手の使用済みカード
pcdiscard = []

#初めの自分のターンに、ノーメソッドエラーを出さないようにする為に定義。
pcguard = 0
pcwiseman = 0

#戦闘開始
puts "あなたが先攻です"

while true

  #カードを１枚ドローする。賢者の効果を使用済みの場合、メソッドを飛ばす。
  if myhand.length == 1
    myhand[1] = xeno.delete_at(0)
    puts "あなたはカードをドローしました"
    puts "引いたのは#{myhand[1]}番のカードです"
    $line
  end

  #カード選択画面を表示
  input = Choice.choice(myhand)

  #使用できるカードがない場合は、こちらのメソッドにループする。
  while (input != myhand[0] && input != myhand[1]) || input == 10 || input == 11 do
    case input
    when 0
      Explanation.tutorial
      input = Choice.choice(myhand)
    when 10
      puts "英雄のカードは手札から使用することができません"
      input = Choice.choice(myhand)
    when 11
      puts "自分の使用済みカード"
      if mydiscard == []
        puts "ありません"
      else
        mydiscard.each do |mydis|
          puts "#{mydis}番"
        end
      end
      puts "相手の使用済みカード"
      if pcdiscard == []
        puts "ありません"
      else
        pcdiscard.each do |pcdis|
          puts "#{pcdis}番"
        end
      end
      $line
      input = Choice.choice(myhand)
    else
      puts "その番号のカードは手札にありません"
      input= Choice.choice(myhand)
    end
  end

  #手札のカードを消去。墓地にカードを送る。
  mydiscard << myhand.delete_at(myhand.find_index(input)) 

  #選んだカードの番号によって分岐が別れる
  myguard, mywiseman = Turn.mytern(myhand, pchand, xeno, hero, mydiscard, pcdiscard, pcguard, input)

  #ここから相手のターン
  if xeno == [] 
    Turn.decknone(myhand, pchand)
  end

  #相手が前のターンに賢者を使った場合カードを３ドローする。xeno.firstでデッキの枚数が少なくてもエラーにならない
  if pcwiseman == 1
    WiseMan.pcwisemans(xeno, pchand)
  end

  if pchand.length == 1
    pchand[1] = xeno.delete_at(0)
    puts "相手がカードを一枚ドローしました"
  end

  input = pchand.delete_at(pchand.find_index(pchand.min))
  pcdiscard << input
  pcguard, pcwiseman = Turn.pcturn(myhand, pchand, xeno, hero, mydiscard, pcdiscard, myguard, input)

  #山札のカードがなくなった場合、互いのカードの数字の大きさで勝敗を決める。
  if xeno == []
    Turn.decknone(myhand, pchand)
  end

  #ここから自分のターンにループ。前回選んだカードが７番だった場合、賢者の効果を発動する。
  if mywiseman == 1
    WiseMan.mywisemans(xeno, myhand)
  end
end
