class Game < Board
    def initialize
        puts "*************************"
        puts "* welcome to MASTERMIND *"
        puts "*************************"
        puts  
    end

    def play
        board = Board.new
        current_turn = 0
        while current_turn < @@which_turn    
            board.take_turn(current_turn)
            current_turn += 1
            
        end
        return loser if current_turn == @@which_turn
    end

    def loser
        puts
        puts ":(.............................."
        puts "           You lose!"
        puts ":(.............................."
        puts
        puts "HAHAHAHAHA!!!!"
        puts "the code was: #{@@code.join}, you fool!"
        exit
    end
end