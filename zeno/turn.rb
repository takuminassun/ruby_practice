require './effect'

module Turn
  #自分のターンのメソッド。カード番号により分岐

  def self.myturn(myhand, pchand, xeno, hero, mydiscard, pcdiscard, pcguard, card)
    myguard = 0
    mywiseman = 0

    case card
    when 1
      Effect.my_one(pcguard, mydiscard, pcdiscard, xeno, pchand)
    when 2
      Effect.my_two(pcguard, mydiscard, pcdiscard, myhand, pchand)
    when 3
      Effect.my_three(pcguard, pchand)
    when 4
      Effect.four
      myguard = 1
    when 5
      Effect.my_five(pcguard, xeno, pchand, pcdiscard)
    when 6
      Effect.my_six(pcguard, myhand, pchand)
    when 7
      p mywiseman
      Effect.seven
      mywiseman = 1
      p mywiseman
    when 8
      Effect.my_eight(pcguard, myhand, pchand)
    when 9
      Effect.my_nine(pcguard, xeno, pchand, myhand, pcdiscard)
    else
      puts "エラーです"
    end
    return myguard, mywiseman
  end

  #相手ターンのメソッド。カード番号により分岐。
  def self.pcturn(myhand, pchand, xeno, hero, mydiscard, pcdiscard, myguard, input)
    #相手がカードを引こうとして山札にカードがなかった場合、数字の大きさで勝敗を決する。
    pcguard = 0
    pcwiseman = 0

    case input
    when 1
      Effect.pc_one(myguard, input, mydiscard, pcdiscard, xeno, myhand, hero)
    when 2
      Effect.pc_two(myguard, input, xeno, myhand, mydiscard, hero)
    when 3
      Effect.pc_three(myguard, input, myhand)
    when 4
      Effect.four
      pcguard = 1
    when 5
      Effect.pc_five(myguard, input, xeno, myhand, hero, pcdiscard)
    when 6
      Effect.pc_six(myguard, input, myhand, pchand)
    when 7
      Effect.seven
      pcwiseman = 1
    when 8
      Effect.pc_eight(myguard, input, myhand, pchand)
    when 9
      Effect.pc_nine(myguard, input, xeno, myhand, mydiscard)
    else
      puts "エラーです"
    end
    return pcguard, pcwiseman
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
