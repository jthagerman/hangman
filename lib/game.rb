
#Game.rb Class countains all the logic for setting up a game and taking turns
class Game
        
    def initialize()
        @word = pick_a_word()
        @guesses = []
        @misses = []
        @tries = 10

        puts "\nWelcome to Hangman your word is #{@word.length} letters long"

      #  puts @word
        take_turn



    end

    def take_turn()
        printBoard(@word,@guesses,@tries)

        while((@tries > 0) && (!check_victory(@guesses,@word)))
            turn = get_turn_input()      
            @word.include?(turn) ?  @guesses.push(turn) : @misses.push(turn)
            if(!@word.include?(turn) )
                @tries = @tries - 1
            end
            printBoard(@word,@guesses,@tries)
        end

        check_victory(@guesses,@word) ? puts("Congrats! You Win!") : puts("\nGAME OVER the word was #{@word}")
    end

    def check_victory(guesses,word)
        guesses.each do |letter|
            if(word.include?(letter))
                word = word.delete(letter)
            end
            if word.length == 0
                return true
            end
        end
        return false
    end

    def get_turn_input()
        turn = ""

        while((turn.match(/^[a-z]$/) == nil))
            puts "\n\nPlease guess a letter"
            turn = gets.chomp.downcase
            if(turn == "save")
                saveGame()
            end
            
            if((@guesses.include? turn) || (@misses.include? turn))
                puts "You already guessed that letter"
                turn = "0"
            end
        end
        return turn
    end

    def pick_a_word()
        wordlist = '5desk.txt'
        wordArray = []
        contents = File.open(wordlist,"r")

        contents.each do |word|
            word.gsub!(/\r\n?/, "");
            if(word.length > 5) && (word.length < 13)
                wordArray.push(word)
            end
        end
       return  wordArray[rand(wordArray.length)]

    end

    def saveGame()
        puts "this functionality is not yet available"
    end

    def printBoard(word,guesses,tries)
        puts( "==" * @word.length)

        output = ""
        word.each_char do |letter|
            if(guesses.include?(letter))
                output += letter
            else
                output += "_"
            end
            output += " "
        end
        
        miss_string = ""

        @misses.each  {|letter| miss_string += letter + " "}

        puts "\n"
        puts "#{output}\n\n"
        puts( "==" * @word.length)
        puts "Misses: #{miss_string}"
        if !check_victory(@guesses,@word)
            puts "\n#{@tries} tries left"
        end
    end
end

