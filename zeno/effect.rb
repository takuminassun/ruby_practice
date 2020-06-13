module Effect
  def self.one(guard, mydiscard, pcdiscard, xeno, hand, myhand, hero, hoge)
    if guard == 1
      num = 1
      effect_four(num)
    else
      puts "少年（革命）のカードを使用しました"
      if (mydiscard + pcdiscard).count(1) == 2
        puts "少年のカードが使われたのは2枚目のため、公開処刑を発動します"
        select_num = 0
        public_execution(xeno, hand, hoge, myhand, discard, select_num)
        if select_num == 10
          puts "英雄（潜伏・転生）の効果により、転生札よりカードを引いて復活します"
          hand[0] = hero
        end
      else
        puts "少年のカードは初めて使われた為、効果を発動しません"
      end
    end
  end

  def self.two(guard, mydiscard, pcdiscard, myhand, hand, hoge, xeno, hero)
    if guard == 1
      num = 2
      effect_four(num)
    else
      puts "兵士（捜査）のカードを使用しました"
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
      puts "相手が持っていると思うカード番号を指定してください"
  
      if hoge == 0
        puts "あなたがいま手に持っているカード : #{myhand[0]}番"
        select_num = gets.to_i
        while select_num < 1 || select_num > 10
          puts "その番号は指定できません"
          puts "１から１０までの番号を指定してください"
          select_num = gets.to_i
        end
      else
        select_num = (xeno + myhand).sample
      end
      puts "#{select_num}番"
      hand[0]
      if select_num == hand[0] && select_num == 10
        puts "相手が持っていたのは英雄のカードでした"
        puts "英雄のカードの効果により、手札を捨てて転生します"
        hoge == 0 ? pcdiscard << hand[0] : mydiscard << hand[0]
        hand[0] = hero
      elsif select_num == hand[0]
        puts "相手が持っていたのは #{hand[0]}番のカードでした" 
        puts hoge == 0 ? "あなたの勝利です" : "あなたの負けです"
        exit
      else
        puts hoge == 0 ? "相手「違います」" : "あなた「違います」"
      end
    end
  end

  def self.three(guard, hand)
    if guard == 1
      num = 3
      effect_four(num)
    else
      puts "占い師(透視)のカードを使用しました"
      puts "相手の手札をオープンします"
      puts "相手が持っているのは#{hand[0]}番のカードです"
    end
  end

  def self.four
    puts "乙女（守護）のカードを使用しました"
    puts "次のターンまで相手の攻撃が無効化されます"
  end

  def self.five(guard, xeno, hand, hero, discard)
    if guard == 1
      num = 5
      effect_four(num)
    else
      puts "死神（疫病）のカードを使用しました。"
      if xeno == []
        puts "山札にカードがない為、死神の効果は発動しません。"
      else
        puts "死神の効果により、カードを一枚ドローしました。"
        hand[1] = xeno.delete_at(0)
        random_num = hand.delete_at(hand.find_index(hand.sample))
        if random_num == 10
          puts "死神の効果により英雄のカードが墓地に送られました。"
          puts "英雄のカードの効果で転生します。"
          hand[0] = hero
        else
          puts "手札の#{random_num}番のカードが墓地に送られました。"
        end
        discard << random_num
      end
    end
  end

  def self.six(guard, myhand, pchand)
    if guard == 1
      num = 6
      effect_four(num)
    else
      puts "貴族のカードを使用しました。"
      puts "あなたが持っていたのは#{myhand[0]}番のカード。"
      puts "相手が持っていたのは#{pchand[0]}番のカード。"
  
      if myhand[0] == pchand[0]
        puts "持っていたカードが互角の為、相打ちです。"
      elsif myhand[0] > pchand[0]
        puts "あなたの勝利です。"
      else myhand[0] < pchand[0]
        puts "あなたの負けです。"
      end
      exit
    end
  end

  def self.seven
    puts "７番の賢者のカードを使用しました"
    puts "次のターンカードを３枚ドローし、一枚選択して手札に加えます"
  end

  def self.eight(guard, myhand, pchand)
    if guard == 1
      num = 8
      effect_four(num)
    else
      #データ移動用
      puts "精霊（交換）のカードを使用します"
      puts "あなたの持っている#{myhand[0]}番のカードと相手の持っている#{pchand[0]}番のカードを交換しました"
      myhand[0], pchand[0] = pchand[0], myhand[0]
    end
  end

  def self.nine(guard, xeno, hand, myhand, discard, hoge)
    if guard == 1
      num = 9
      effect_four(num)
    else
      puts "皇帝（公開処刑）のカードを使用しました"
      select_num = 0
      public_execution(xeno, hand, hoge, myhand, discard, select_num)
      if select_num == 10
        puts "英雄のカードは転生できない為、あなたの勝利です"
        exit
      end
    end
  end

  def self.effect_four(num)
    puts "#{num}番の効果を発動しようとしましたが、相手の乙女（守護）のカードの効果により無効化されます"
  end

  def self.public_execution(xeno, hand, hoge, myhand, discard, select_num)
    if xeno == []
      puts "山札にカードがない為、効果を発動しません"
      puts $line
    else
      hand[1] = xeno.delete_at(0)
      puts "相手がカードをドローし、持っているカードはオープンします"
      puts "相手が持っていたのは#{hand[0]}番と#{hand[1]}番のカードです"
      puts "どちらのカードを指定しますか？"
      puts $line

      if hoge == 0
        puts "あなたの手札にある現在のカードは#{myhand[0]}番のカードです"
        select_num = gets.to_i
        pcdiscard = hand.delete_at(hand.find_index(select_num))
      else
        hand[1] = xeno.delete_at(0)
        select_num = hand.delete_at(hand.find_index(hand.max))
        mydiscard << select_num
      end
      puts "#{select_num}番のカードを捨てさせました"
    end
  end
end
