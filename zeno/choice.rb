module Choice
  #カード選択画面を表示
  def self.choice(myhand, line)
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
end
