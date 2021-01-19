class  Controller
    def initialize()
        setup_game()
    end

    def setup_game()
        puts "\n\nWelcome to Hangman, would you like to 1) start game"
        puts "                                      2) load game"
        puts "                                      3) quit game"
        
        case(gets.chomp.downcase)
            when '1'
                start_game()
            when '2'
                load_game()
            when '3'
                quit_game()
            else
                puts "Invalid Input, please try again"
                setup_game()
        end
    end

        
    def start_game()
        puts "hit"
    end
    def load_game()
        puts "more hit"
    end
    def quit_game()
        puts "Thank You For Playing! <3"
        exit(0)
    end
end
