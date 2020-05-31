line = "------------------------------------------"
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

#カード選択画面を表示
def choice(myhand, line)
  puts "あなたの手札にあるのは#{myhand[0]}番と#{myhand[1]}番のカードです"
  puts "どちらのカードを使用しますか"
  puts "#{myhand[0]}番のカードを使用する"
  puts "#{myhand[1]}番のカードを使用する"
  puts "0番:チュートリアルを閲覧する"
  puts "11番:使用済みカードを確認する"
  puts line
  input = gets.to_i
  return input
end

#自分の賢者発動
def mywisemans(line, xeno, myhand)
  wiseman = xeno.first(3)
  puts "賢者のカードの効果により、カードをドローします"
  wiseman.each do |wise|
    puts "#{wise}番"
  end
  puts "あなたの現在の手札にあるのは#{myhand[0]}番のカードです。"
  puts "どのカードを手札に加えますか。"
  puts line
  input = gets.to_i

  while !wiseman.any?(input) do
    puts "そのカード番号は引いたカードの中にありません"

    wiseman.each do |wise|
      puts "#{wise}番"
    end

    puts "再度番号を入力してください"
    input = gets.to_i
  end

  myhand[1] = xeno.delete_at(xeno.find_index(input))
  xeno = xeno.shuffle
  puts "#{myhand[1]}番のカードを手札に加えました"
  puts "残りのカードを山札に戻してシャッフルします"
end

#PCの賢者発動
def pcwisemans(line, xeno, pchand)
  pchand[1] = xeno.delete_at(xeno.find_index(xeno.first(3).max))
  xeno = xeno.shuffle

  puts "相手は賢者（選択）のカードの効果により、カードをドローしました"
  puts "カードを一枚選んで残りを山札に戻し、シャッフルしました"
  puts line 
end

#自分のターンのメソッド。カード番号により分岐
def mytern(myhand, pchand, xeno, hero, mydiscard, pcdiscard, line, pcguard, card)
  mywiseman = 0
  myguard = 0

  case card
  when 1
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
  when 2
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
  when 3
    if pcguard == 1
      puts "相手の乙女（守護）のカードの効果により無効化されました"
    else
      puts "占い師（透視）のカードを使用しました"
      puts "相手が手に持っているカードをオープンします"
      puts "相手が持っていたのは#{pchand[0]}番のカードです"
    end
  when 4
    puts "あなたが乙女（守護）のカードを使用しました"
    puts "次のターンまで相手の攻撃が無効化されます"
    myguard = 1
  when 5
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
        input = pchand.delete_at(pchand.find_index(pchand.sample))
        if input == 10
          puts "死神の効果により、相手の英雄のカードが墓地に送りました"
          puts "相手は英雄の効果により、転生札よりカードを引いて復活します"
          pchand[0] = hero
        else
          puts "死神の効果により、相手の#{input}番のカードが墓地に送られました"
        end
        pcdiscard << input
      end
    end
  when 6
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
  when 7
    puts "７番の賢者のカードを使用しました"
    puts "次のターンカードを３枚ドローし、一枚選択して手札に加えます"
    mywiseman = 1
  when 8
    if pcguard == 1
      puts "相手の乙女（守護）のカードの効果により無効化されました"
    else
      #データ移動用
      puts "精霊（交換）のカードを使用します"
      puts "あなたの持っている#{myhand[0]}番のカードと相手の持っている#{pchand[0]}番のカードを交換しました"
      myhand[0], pchand[0] = pchand[0], myhand[0]
    end
  when 9
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
        puts line
        input = gets.to_i
        pcdiscard = pchand.delete_at(pchand.find_index(input))
        puts "#{input}番のカードを捨てさせました"
        if input == 10
          puts "英雄のカードは転生できない為、あなたの勝利です"
          exit
        end
      end
    end
  else
    puts "エラーです"
  end
  puts line
  return myguard, mywiseman
end

#相手ターンのメソッド。カード番号により分岐。
def pctern(myhand, pchand, xeno, hero, mydiscard, pcdiscard, line, myguard, input)
  #相手がカードを引こうとして山札にカードがなかった場合、数字の大きさで勝敗を決する。
  pcguard = 0
  pcwiseman = 0

  case input
  when 1
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

          input = myhand.delete_at(myhand.find_index(myhand.max))
          puts "相手があなたの手札から#{input}番のカードを墓地へ送りました"
          if input == 10
            puts "英雄（潜伏・転生）の効果により、転生札よりカードを引いて復活します"
            myhand[0] = hero
          end
          mydiscard << input
        end
      else
        puts "相手が少年のカードを使用しました"
        puts "少年のカードが使われたのは1枚目のため、効果を発動しません"
      end
    end
  when 2
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
  when 3
    if myguard == 1
      puts "乙女（守護の）効果により、相手の#{input}番のカードの効果を無効化しました"
    else
      puts "相手が占い師(透視)のカードを使用しました"
      puts "相手があなたのカード番号が#{myhand[0]}番であることを確認しました"
    end
  when 4
    puts "相手が乙女（守護）のカードを使用しました"
    puts "次のターンまであなたの攻撃が無効化されます"
    pcguard = 1
  when 5
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
  when 6
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
  when 7
    puts "相手が賢者（選択）のカードを使用しました"
    puts "相手は次のターンにカードを3枚ドローし、１枚を選択して手札に加えます"
    pcwiseman = 1
  when 8
    if myguard == 1
      puts "乙女（守護の）効果により、相手の#{input}番のカードの効果を無効化しました"
    else
      puts "相手が精霊（交換)のカードを使用しました"
      puts "あなたの持っている#{myhand[0]}番のカードと、相手の持っている#{pchand[0]}番のカードを交換しました"
      myhand[0], pchand[0] = pchand[0], myhand[0]
    end
  when 9
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
  else
    puts "エラーです"
  end
  puts line
  return pcguard, pcwiseman
end

#山札にカードがなくなった場合のメソッド。これで決着。
def decknone(myhand, pchand)
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

#カード選択画面で０番を入力した場合、チュートリアルを表示する。
def tutorial(line)
  puts "カードの種類は全部で１０種類です"

  puts "① 少年（革命）"
  puts "１枚目の捨て札は何の効果も発動しないが、場に２枚目が出た時には皇帝と同じ効果「公開処刑」が発動する"
  puts line

  puts "② 兵士（捜査）"
  puts "指定した相手の手札を言い当てると相手は脱落する。"
  puts line

  puts "③ 占い師（透視）"
  puts "指定した相手の手札を見る。"
  puts line

  puts "④ 乙女（守護）"
  puts "次の自分の手番まで自分への効果を無効にする。"
  puts line

  puts "⑤ 死神（疫病）"
  puts "指名した相手に山札から１枚引かせる。"
  puts "２枚になった相手の手札を非公開にさせたまま、１枚を指定して捨てさせる。"
  puts line

  puts "⑥ 貴族（対決）"
  puts "指名した相手と手札を見せ合い、数字の小さい方が脱落する。"
  puts "見せ合う際には他のプレイヤーに見られないよう密かに見せ合う。"
  puts line

  puts "⑦ 賢者（選択）"
  puts "次の手番で山札から１枚引くかわりに３枚引き、そのうち１枚を選ぶことができる。"
  puts "残り２枚は山札へ戻す。"
  puts line

  puts "⑧ 精霊（交換）"
  puts "指名した相手の手札と自分の持っている手札を交換する。"
  puts line


  puts "⑨ 皇帝（公開処刑）"
  puts "指名した相手に山札から１枚引かせて、手札を２枚とも公開させる。"
  puts "そしてどちらか１枚を指定し捨てさせる。"
  puts line

  puts "⑩ 英雄（潜伏・転生）"
  puts "場に出すことができず、捨てさせられたら脱落する。"
  puts "皇帝以外に脱落させらた時に転生札で復活する。"
  puts line
end

#戦闘開始
puts "あなたが先攻です"

while true

  #カードを１枚ドローする。賢者の効果を使用済みの場合、メソッドを飛ばす。
  if myhand.length == 1
    myhand[1] = xeno.delete_at(0)
    puts "あなたはカードをドローしました"
    puts "引いたのは#{myhand[1]}番のカードです"
    puts line
  end

  #カード選択画面を表示
  input = choice(myhand, line)

  #使用できるカードがない場合は、こちらのメソッドにループする。
  while (input != myhand[0] && input != myhand[1]) || input == 10 || input == 11 do
    case input
    when 0
      tutorial(line)
      input = choice(myhand, line)
    when 10
      puts "英雄のカードは手札から使用することができません"
      input = choice(myhand, line)
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
      puts line
      input = choice(myhand, line)
    else
      puts "その番号のカードは手札にありません"
      input= choice(myhand, line)
    end
  end

  #手札のカードを消去。墓地にカードを送る。
  mydiscard << myhand.delete_at(myhand.find_index(input)) 

  #選んだカードの番号によって分岐が別れる
  myguard, mywiseman = mytern(myhand, pchand, xeno, hero, mydiscard, pcdiscard, line, pcguard, input)

  #ここから相手のターン
  if xeno == [] 
    decknone(myhand, pchand)
  end

  #相手が前のターンに賢者を使った場合カードを３ドローする。xeno.firstでデッキの枚数が少なくてもエラーにならない
  if pcwiseman == 1
    pcwisemans(line, xeno, pchand)
  end

  if pchand.length == 1
    pchand[1] = xeno.delete_at(0)
    puts "相手がカードを一枚ドローしました"
  end

  input = pchand.delete_at(pchand.find_index(pchand.min))
  pcdiscard << input
  pcguard, pcwiseman = pctern(myhand, pchand, xeno, hero, mydiscard, pcdiscard, line, myguard, input)

  #山札のカードがなくなった場合、互いのカードの数字の大きさで勝敗を決める。
  if xeno == []
    decknone(myhand, pchand)
  end

  #ここから自分のターンにループ。前回選んだカードが７番だった場合、賢者の効果を発動する。
  if mywiseman == 1
    mywisemans(line, xeno, myhand)
  end
end
