#Game.rb Class countains all the logic for setting up a game and taking turns

require 'json'

class Game
        
    def initialize(word="",guesses="",misses="",tries="")
        
        if(word == "")
            @word = pick_a_word()
            @guesses = []
            @misses = []
            @tries = 10
            puts "\nWelcome to Hangman your word is #{@word.length} letters long"
        else
            puts "\nWelcome back:"
            @word = word
            (guesses != nil) ? @guesses = guesses : @guesses = []
            (misses != nil) ?  @misses = misses : @misses = []
            @tries = tries
            puts "you have #{tries} tries left"
        end
        take_turn
    end

    def to_json
        JSON.dump ({
          :word => @word,
          :guess => @guesses,
          :misses => @misses,
          :tries => @tries
        })
    end

    def self.from_json(string)
        data = JSON.load string
        self.new(data['word'], data['guess'], data['misses'], data['tries'])
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
            puts "\n\nPlease guess a letter, save to quit"
            turn = gets.chomp.downcase
            if(turn == "save")
                saveGame()
                exit(0)
            elsif(turn == "quit")

                puts "Thanks for Playing"
                exit(0)
            elsif(turn == @word)
                puts("Congrats! You Win!")   
                exit(0)      
            elsif((@guesses.include? turn) || (@misses.include? turn))
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
        directory = "saves"

        if (!File.directory?(directory))
            Dir.mkdir(directory)
        end

        puts "Please enter a save file name"
       
        filename = String.new
        while((filename.match(/^[a-zA-Z0-9]+$/) == nil) )
            
            filename = gets.chomp.downcase
            if(File.exist?("../hangman/saves/#{filename}.json"))
                puts "That filename already exists please choose another"
                filename = "-----"
            end

            if(filename.match(/^[a-zA-Z0-9]+$/) == nil)
                puts "Invalid Input\nPlease Enter a valid Filename"
            end

        end

        File.write("../hangman/saves/#{filename}.json", self.to_json)
        puts("game saved, thank you for playing")
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
        puts "\n#{output}\n\n"
        puts( "==" * @word.length)
        puts "Misses: #{miss_string}"
        if !check_victory(@guesses,@word)
            puts "\n#{@tries} tries left"
        end
    end
end

