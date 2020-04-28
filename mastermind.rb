require 'pry'

class Board
    @@royg = ["R", "O", "Y", "G", "B", "V"]
    def initialize
        @board = []
        @player_guess = []
        @@code = code_picker
        #@position = 1

        puts "please choose difficulty level: (N)ormal - 12 turns, (H)ard - 8 turns, (G)od mode - 3 turns, (P)ure luck - 1 turn"
        
        mode_hash = {
            N: 12, H: 8, G: 3, P: 1
        }
        
        @difficulty = gets.chomp
        @difficulty.upcase!
        
        if mode_hash.keys.include?(@difficulty.upcase.to_sym)
            @@which_turn = mode_hash[@difficulty.to_sym]
        else
            puts "Please only enter: N/n, H/h, G/g, or P/p"
            initialize
        end

        @@which_turn.times do
            @board.push(['-','-','-','-'])
        end
        show_board
    end

    def show_board
        #puts "showing board..."
        @board.each { |row|
            puts row.join('')
        }
    end

    def show_code
        puts @@code.join('')
    end

    def set_row(new_arr, turn)
        #puts "setting row..."
        @board[turn] = new_arr
    end

    def build_guess_array(position)
        while (position - 1) < 4
            puts 
            #show_board
            #binding.pry
            puts "please choose: (R)ed, (O)range, (Y)ellow, (G)reen, (B)lue, (V)iolet \nfor position #{position}: "
            guess = gets.chomp
            guess.upcase!
            if !@@royg.include?(guess)
                puts "invalid guess"
                return build_guess_array(position)
            
            else @@royg.include?(guess)
                @player_guess.push(guess)
                position += 1
            end
        end
    end

    def take_turn(which_turn)
        #puts "turn no. #{which_turn + 1}"
        game_length = @board.length
        position = 1
        build_guess_array(position)
        set_row(@player_guess, which_turn)
        #analyze_guess(@player_guess)
        feed_back
    end

    def feed_back
        #puts "providing feedback..."
        if @player_guess.length == 4 && @@code != @player_guess
            puts
            puts "*****************************"
            puts "good guess, here's your hint:"
            puts "#{analyze_guess(@player_guess)}"
            puts "*****************************"
            puts

            reset_guess_array
            show_board
        else
            return winner
        end
    end

    private

    def reset_guess_array
        #puts "resetting guess array"
        @player_guess = []
    end

    def analyze_guess(array)
        #puts "analyzing guess..."
        hint_array = []
        return winner if @@code == array 
        array.each_with_index { |el, index|
            if (el == @@code[index])
                hint_array.push("black")
            elsif (el != @@code[index] && @@code.include?(el))
                hint_array.push("white")
            else
                #hint_array.push("...")
            end
        }
        
        

        puts "\n#{hint_array.shuffle[0]} \t#{hint_array.shuffle[1]} \n#{hint_array.shuffle[2]} \t#{hint_array.shuffle[3]}"
        #puts "\n#{@@code}"
    end



    def winner
        puts "**********WINNER*********"
        puts "* you cracked the code! *"
        puts "**********WINNER*********"
        exit
    end

    def code_picker
        return [
            @@royg[rand(6)],
            @@royg[rand(6)],
            @@royg[rand(6)],
            @@royg[rand(6)]
        ]
    end
end

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


game = Game.new
game.play

#puts board.analyze_guess(["O", "Y", "G", "R"])