require './effect'

module Turn
  # ターンのメソッド。カード番号により分岐
  def self.turn(myhand, pchand, xeno, hero, mydiscard, pcdiscard, guard, card, hoge)
    if hoge == 0
      myguard = 0
      mywiseman = 0
    else
      pcguard = 0
      pcwiseman = 0
      myhand, pchand = pchand, myhand
    end
  
    case card
    when 1
      Effect.one(guard, mydiscard, pcdiscard, xeno, pchand, myhand, hero, hoge)
    when 2
      # 入れ替えなし
      myhand = pchand unless hoge == 0
      Effect.two(guard, mydiscard, pcdiscard, myhand, pchand, hoge, xeno, hero)
    when 3
      Effect.three(guard, pchand)
    when 4
      Effect.four
      hoge == 0 ? myguard = 1 : pcguard = 1
    when 5
      Effect.five(guard, xeno, pchand, hero, pcdiscard)
    when 6
      # 入れ替えなし
      myhand, pchand = pchand, myhand unless hoge == 0
      Effect.six(guard, myhand, pchand)
    when 7
      Effect.seven
      hoge ? mywiseman = 1 : pcwiseman = 1
    when 8
      # 入れ替えなし
      myhand, pchand = pchand, myhand unless hoge == 0
      Effect.eight(guard, myhand, pchand)
    when 9
      Effect.nine(guard, xeno, pchand, myhand, pcdiscard, hoge)
    else
      puts "エラーです"
    end
  
    if hoge == 0
      return myguard, mywiseman
    else
      return pcguard, pcwiseman
    end
  end

  #山札にカードがなくなった場合のメソッド。これで決着。
  def self.decknone(myhand, pchand)
    puts "山札のカードがなくなりました"
    puts "お互いの持っているカードをオープンします"
    puts "あなたの持っているカードは#{myhand[0]}番です"
    puts "相手が持っているカードは#{pchand[0]} 番です"

    if myhand[0] == pchand[0]
      puts "持っていたカードが同じの為、相打ちです"  
    elsif myhand[0] > pchand[0]
      puts "あなたの勝ちです"
    else myhand[0] < pchand[0]
      puts "あなたの負けです"
    end
    exit
  end
end
