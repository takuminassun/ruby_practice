module Effect
  def self.my_one(pcguard, mydiscard, pcdiscard, xeno, pchand)
    if pcguard == 1
      puts "相手の乙女（守護）のカードの効果により無効化されました"
    else
      puts "少年（革命）のカードを使用しました"
      if (mydiscard + pcdiscard).count(1) == 2
        if xeno == []
          puts "山札にカードがない為、効果を発動しません"
          puts "----------------------------"
        else
          puts "少年のカードが使われたのは2枚目のため、公開処刑を発動します"
          pchand[1] = xeno.delete_at(0)
          puts "相手がカードをドローし、持っているカードはオープンします"
          puts "持っていたのは#{pchand[0]}番と#{pchand[1]}番のカードです"
          puts "どちらのカードを指定しますか？"
          input = gets.to_i
          while !pchand.any?(input) do
            puts "その番号のカードは相手の手札にありません"
            puts "相手が持っているのは#{pchand[0]}番と#{pchand[1]}番のカードです"
            puts "もう一度番号を指定してください"
            input = gets.to_i
          end

          pcdiscard << pchand.delete_at(pchand.find_index(input))
          puts "#{input}番のカードを捨てさせました"

          if input == 10
            puts "英雄（潜伏・転生）の効果により、転生札よりカードを引いて復活します"
            pchand[0] = hero
          end
        end 
      else
        puts "少年のカードは初めて使われた為、効果を発動しません"
      end
    end
  end

  def self.my_two(pcguard, mydiscard, pcdiscard, myhand, pchand)
    if pcguard == 1
      puts "相手の乙女（守護）のカードの効果により無効化されました"
    else
      puts "兵士（捜査）のカードを使用しました"
      puts "自分の使用済みカード"
      mydiscard.each do |mydis|
        puts "#{mydis}番"
      end
      puts "相手の使用済みカード"
      if pcdiscard == []
        puts "ありません"
      else
        pcdiscard.each do |pcdis|
          puts "#{pcdis}番"
        end
      end
      puts "あなたがいま手に持っているカード"
      puts "#{myhand[0]}番"
      puts "相手が持っていると思うカード番号を指定してください"
      input = gets.to_i
      while input < 1 || input > 10
        puts "その番号は指定できません"
        puts "１から１０までの番号を指定してください"
        input = gets.to_i
      end
      if input == pchand[0] && input == 10
        puts "相手が持っていたのは英雄のカードでした"
        puts "英雄のカードの効果により、手札を捨てて転生します"
  
        pcdiscard << pchand[0]
        pchand[0] = hero
      elsif input == pchand[0]
        puts "相手が持っていたのは #{pchand[0]}番のカードでした" 
        puts "あなたの勝利です"
        exit
      else
        puts "相手「違います」"
      end
    end
  end

  def self.my_three(pcguard, pchand)
    if pcguard == 1
      puts "相手の乙女（守護）のカードの効果により無効化されました"
    else
      puts "占い師（透視）のカードを使用しました"
      puts "相手が手に持っているカードをオープンします"
      puts "相手が持っていたのは#{pchand[0]}番のカードです"
    end
  end

  def self.four
    puts "乙女（守護）のカードを使用しました"
    puts "次のターンまで相手の攻撃が無効化されます"
  end

  def self.my_five(pcguard, xeno, pchand, pcdiscard)
    if pcguard == 1
      puts "相手の乙女（守護）のカードの効果により無効化されました"
    else
      puts "あなたが死神（疫病）のカードを使用しました。"
      if xeno == []
        puts "山札にカードがない為、死神の効果は発動しません。"
      else
        puts "死神の効果により、相手がカードを一枚ドローしました。"
        pchand[1] = xeno.delete_at(0)
  
        #PCのカードからランダムにデータを削除
        random_num = pchand.delete_at(pchand.find_index(pchand.sample))
        if random_num == 10
          puts "死神の効果により、相手の英雄のカードが墓地に送りました"
          puts "相手は英雄の効果により、転生札よりカードを引いて復活します"
          pchand[0] = hero
        else
          puts "死神の効果により、相手の#{random_num}番のカードが墓地に送られました"
        end
        pcdiscard << random_num
      end
    end
  end

  def self.my_six(pcguard, myhand, pchand)
    if pcguard == 1
      puts "相手の乙女（守護）のカードの効果により無効化されました"
    else
      puts "あなたが貴族のカードを使用しました"
      puts "あなたが持っていたのは#{myhand[0]}番のカード"
      puts "相手が持っていたのは#{pchand[0]}番のカード"
  
      if myhand[0] == pchand[0]
        puts "持っていたカードが互角の為、相打ちです"
      elsif myhand[0] > pchand[0]
        puts "あなたの勝利です"
      else myhand[0] < pchand[0]
        puts "あなたの負けです"
      end
      exit
    end
  end

  def self.seven
    puts "７番の賢者のカードを使用しました"
    puts "次のターンカードを３枚ドローし、一枚選択して手札に加えます"
  end

  def self.my_eight(pcguard, myhand, pchand)
    if pcguard == 1
      puts "相手の乙女（守護）のカードの効果により無効化されました"
    else
      #データ移動用
      puts "精霊（交換）のカードを使用します"
      puts "あなたの持っている#{myhand[0]}番のカードと相手の持っている#{pchand[0]}番のカードを交換しました"
      myhand[0], pchand[0] = pchand[0], myhand[0]
    end
  end

  def self.my_nine(pcguard, xeno, pchand, myhand, pcdiscard)
    if pcguard == 1
      puts "相手の乙女（守護）のカードの効果により無効化されました"
    else
      puts "皇帝（公開処刑）のカードを使用しました"
      if xeno == []
        puts "山札にカードがない為、効果を発動しません"
        puts "----------------------------"
      else
        pchand[1] = xeno.delete_at(0)
        puts "相手がカードをドローし、持っているカードはオープンします"
        puts "相手が持っていたのは#{pchand[0]}番と#{pchand[1]}番のカードです"
        puts "どちらのカードを指定しますか？"
        puts "あなたの手札にある現在のカードは#{myhand[0]}番のカードです"
        puts $line
        select_num = gets.to_i
        pcdiscard = pchand.delete_at(pchand.find_index(select_num))
        puts "#{select_num}番のカードを捨てさせました"
        if select_num == 10
          puts "英雄のカードは転生できない為、あなたの勝利です"
          exit
        end
      end
    end
  end


  def self.pc_one(myguard, input, mydiscard, pcdiscard, xeno, myhand, hero)
    if myguard == 1
      puts "乙女（守護の）効果により、相手の#{input}番のカードの効果を無効化しました"
    else
      if (mydiscard + pcdiscard).count(1) == 2
        puts "相手が少年（革命）のカードを使用しました"
        puts "少年のカードが使われたのは二枚目です"

        if xeno == []
          puts "山札が０枚の為、効果はは発動しませんでした"
        else
          puts "少年のカードの効果により、公開処刑を発動します"
          myhand[1] = xeno.delete_at(0)
          puts "少年のカードの効果により、#{myhand[1]}番のカードをドローしました"

          random_num = myhand.delete_at(myhand.find_index(myhand.max))
          puts "相手があなたの手札から#{random_num}番のカードを墓地へ送りました"
          if random_num == 10
            puts "英雄（潜伏・転生）の効果により、転生札よりカードを引いて復活します"
            myhand[0] = hero
          end
          mydiscard << random_num
        end
      else
        puts "相手が少年のカードを使用しました"
        puts "少年のカードが使われたのは1枚目のため、効果を発動しません"
      end
    end
  end

  def self.pc_two(myguard, input, xeno, myhand, mydiscard, hero)
    if myguard == 1
      puts "乙女（守護の）効果により、相手の#{input}番のカードの効果を無効化しました"
    else
      puts "相手が兵士（捜査）のカードを使用しました"
      puts "番号を宣言します"
      #デッキのカードと自分のカードからランダムに番号を抽出
      input = (xeno + myhand).sample 
      puts "相手「#{input}番」"
      if myhand.any?(input)

        if myhand[0] == 10
          puts "あなたの持っていた英雄のカードが墓地にいきました"
          puts "英雄の効果により、転生札よりカードを引いて復活します"
          mydiscard << myhand[0]
          myhand[0] = hero
        else
          puts "あなたの手札にあったのは#{myhand[0]}番のカードです"
          puts "あなたの負けです"
          exit
        end
      else
        puts "あなた「違います」"
      end
    end
  end

  def self.pc_three(myguard, input, myhand)
    if myguard == 1
      puts "乙女（守護の）効果により、相手の#{input}番のカードの効果を無効化しました"
    else
      puts "相手が占い師(透視)のカードを使用しました"
      puts "相手があなたのカード番号が#{myhand[0]}番であることを確認しました"
    end
  end

  def self.pc_five(myguard, input, xeno, myhand, hero, pcdiscard)
    if myguard == 1
      puts "乙女（守護の）効果により、相手の#{input}番のカードの効果を無効化しました"
    else
      puts "相手が死神（疫病）のカードを使用しました。"
      if xeno == []
        puts "デッキにカードがなかったため、効果を発動しません。"
      else
        myhand[1] = xeno.delete_at(0)
        input = myhand.delete_at(myhand.find_index(myhand.sample))
        if input == 10
          puts "相手が英雄のカードが墓地に送られました。"
          puts "英雄のカードの効果で転生します。"
          myhand[0] = hero
        else
          puts "あなたの手札の#{input}番のカードが墓地に送られました。"
        end
        pcdiscard << input
      end
    end
  end

  def self.pc_six(myguard, input, myhand, pchand)
    if myguard == 1
      puts "乙女（守護の）効果により、相手の#{input}番のカードの効果を無効化しました"
    else
      puts "相手が貴族のカードを使用しました。"
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

  def self.pc_eight(myguard, input, myhand, pchand)
    if myguard == 1
      puts "乙女（守護の）効果により、相手の#{input}番のカードの効果を無効化しました"
    else
      puts "相手が精霊（交換)のカードを使用しました"
      puts "あなたの持っている#{myhand[0]}番のカードと、相手の持っている#{pchand[0]}番のカードを交換しました"
      myhand[0], pchand[0] = pchand[0], myhand[0]
    end
  end

  def self.pc_nine(myguard, input, xeno, myhand, mydiscard)
    if myguard == 1
      puts "乙女（守護の）効果により、相手の#{input}番のカードの効果を無効化しました"
    else
      puts "相手が皇帝（公開処刑）のカードを使用しました"
      if xeno == []
        puts "山札にカードがなかった為、効果を発動しません"
      else
        myhand[1] = xeno.delete_at(0)

        input << myhand.delete_at(myhand.find_index(myhand.max))
        if input == 10
          puts "相手があなたの持っていた英雄のカードを墓地に送りました"
          puts "あなたの負けです"
          exit
        else
          puts "相手があなたの持っていた#{input}番のカードを墓地に送りました"
        end
        mydiscard << input
      end
    end
  end
end