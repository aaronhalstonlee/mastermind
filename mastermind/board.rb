class Board
    
    @@royg = ["R", "O", "Y", "G", "B", "V"]
    
    def initialize
        @board = []
        @player_guess = []
        @@code = code_picker

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
        @board.each { |row|
            puts row.join('')
        }
    end

    def show_code
        puts @@code.join('')
    end

    def set_row(new_arr, turn)
        @board[turn] = new_arr
    end

    def build_guess_array(position)
        while (position - 1) < 4
            puts 
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
        game_length = @board.length
        position = 1
        build_guess_array(position)
        set_row(@player_guess, which_turn)
        feed_back
    end

    def feed_back
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
        @player_guess = []
    end

    def analyze_guess(array)
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