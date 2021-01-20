class  Controller
    
    require_relative 'controller'
    require_relative 'game'
   
    def initialize()
        setup_game()
    end

    def setup_game()
        puts "\n\nWelcome to Hangman, would you like to:\n\t1) start game"
        puts "\t2) load game"
        puts "\t3) quit game"
        
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
        puts "Type save anytime to save game"
        run = Game.new()
        setup_game()
    end
    def load_game()
        puts "more hit"
    end
    def quit_game()
        puts "Thank You For Playing! <3"
        exit(0)
    end
end
