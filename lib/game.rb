class Game
        
    wordlist = '5desk.txt'
    wordArray = []
    longestword = ''

    contents = File.open(wordlist)
    contents.each do |word|
        if word.length > longestword.length
            longestword = word
        end
        if(word.length > 5) && (word.length < 13)
        
            wordArray.push(word)
        end
    end
    puts wordArray.length
    puts longestword


    def pick_a_word(wordArray)
        puts wordArray[rand(wordArray.length)]
    end
end