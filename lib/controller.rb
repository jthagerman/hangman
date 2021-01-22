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
        puts "Type save anytime to save game, quit to quit"
        run = Game.new()
        setup_game()
    end
    def load_game()


        if (!File.directory?('saves'))
            puts "no saves yet\n starting new game"
            start_game()
        else
            saves = Dir.open("../hangman/saves")

            puts "\n\nHere are the save files please select one:"
            puts "=========================================="
            count = 1
            saves.each do |file|
                if(file.include? ".json" )
                file = file.delete_suffix('.json')
                puts "\t#{count}) #{file}"
                count += 1
                end
            end

            



        end

    end
    def quit_game()
        puts "Thank You For Playing! <3"
        exit(0)
    end
end
