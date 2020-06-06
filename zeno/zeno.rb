require './explanation'
require './turn'
require './choice'
require './wise_man'

$line = "------------------------------------------"
deck = [10,9,8,8,7,7,6,6,5,5,4,4,3,3,2,2,1,1].shuffle

# 自分と相手に札を配る
myhand = [deck.delete_at(0)]
pchand = [deck.delete_at(0)]

#山札の一番下にあるヒーローカード
hero = deck.delete_at(0)
# 自分と相手の使用済みカード
mydiscard = []
pcdiscard = []

#初めの自分のターンに、ノーメソッドエラーを出さないようにする為に定義。
myguard = 0
pcguard = 0
mywiseman = 0
pcwiseman = 0

#戦闘開始
p "あなたが先攻です"

while true
  p "あなたのターンです"
  p mywiseman
  #ここから自分のターンにループ。前回選んだカードが７番だった場合、賢者の効果を発動する。
  WiseMan.mywisemans(deck, myhand) if mywiseman == 1

  #カードを１枚ドローする。賢者の効果を使用済みの場合、メソッドを飛ばす。
  if myhand.length == 1
    myhand[1] = deck.delete_at(0)
    puts "あなたはカードをドローしました"
    puts "引いたのは#{myhand[1]}番のカードです"
    puts $line
  end

  #カード選択画面を表示
  selected_number = Choice.indicate(myhand)

  #使用できるカードがない場合は、こちらのメソッドにループする。
  while (selected_number != myhand[0] && selected_number != myhand[1]) ||
         selected_number == 10 ||
         selected_number == 11 do

    case selected_number
    when 0
      Explanation.tutorial
      selected_number = Choice.indicate(myhand)
    when 10
      puts "英雄のカードは手札から使用することができません"
      selected_number = Choice.indicate(myhand)
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
      puts $line
      selected_number = Choice.indicate(myhand)
    else
      puts "その番号のカードは手札にありません"
      selected_number= Choice.indicate(myhand)
    end
  end

  #手札のカードを消去。墓地にカードを送る。
  mydiscard << myhand.delete_at(myhand.find_index(selected_number)) 

  #選んだカードの番号によって分岐が別れる
  myguard, mywiseman = Turn.myturn(myhand, pchand, deck, hero, mydiscard, pcdiscard, pcguard, selected_number)

  p 'あなたのターンは終了です'
  puts $line

  #ここから相手のターン
  p '相手のターンです'
  Turn.decknone(myhand, pchand) if deck == []

  #相手が前のターンに賢者を使った場合カードを３ドローする。xeno.firstでデッキの枚数が少なくてもエラーにならない
  WiseMan.pcwisemans(deck, pchand) if pcwiseman == 1

  if pchand.length == 1
    pchand[1] = deck.delete_at(0)
    puts "相手がカードを一枚ドローしました"
  end

  selected_number = pchand.delete_at(pchand.find_index(pchand.min))
  pcdiscard << selected_number
  pcguard, pcwiseman = Turn.pcturn(myhand, pchand, deck, hero, mydiscard, pcdiscard, myguard, selected_number)

  #山札のカードがなくなった場合、互いのカードの数字の大きさで勝敗を決める。
  Turn.decknone(myhand, pchand) if deck == []

  p '相手のターンは終了です'
  puts $line
end
