module WiseMan
  #自分の賢者発動
  def self.mywisemans(xeno, myhand)
    wiseman = xeno.first(3)
    puts "賢者のカードの効果により、カードをドローします"
    wiseman.each do |wise|
      puts "#{wise}番"
    end
    puts "あなたの現在の手札にあるのは#{myhand[0]}番のカードです。"
    puts "どのカードを手札に加えますか。"
    puts $line
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
  def self.pcwisemans(xeno, pchand)
    pchand[1] = xeno.delete_at(xeno.find_index(xeno.first(3).max))
    xeno = xeno.shuffle

    puts "相手は賢者（選択）のカードの効果により、カードをドローしました"
    puts "カードを一枚選んで残りを山札に戻し、シャッフルしました"
    puts $line
  end
end