class Game
    @@board = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
    ]
    @@isWinner = false
    @@WIN_INDEX = [
        [0,4,8],[0,3,6],[0,1,2],[2,4,6],[2,5,8],[3,4,5],[6,7,8],[1,4,7]
    ]

    @@moveCount = 0

    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @@players = [player1, player2]
    end

    def startGame
        turn = self.draw_who_start
        puts "Hi"
        until(@@isWinner == true)
            currentPlayer = @@players[turn]
            change_board_sign(user_choice(currentPlayer), currentPlayer)
            @@players[0], @@players[1] = @@players[1], @@players[0]
            checkWinner(currentPlayer.playerChoices, currentPlayer)
        end
    end

    def showBoard
        print "\n"
        @@board.each_with_index do |row, idxR|
            row.each_with_index do |column, idxC|
                print idxC.odd? ? "| #{column} |": " #{column} "
            end
            print (idxR != 2) ? "\n---+---+---\n": "\n\n"
        end
    end


    def move
        choice = user_choice(player)
    end

    def user_choice(player)
        choice = 0
        until (choice != 0 && @@board.flatten.include?(choice))
            self.showBoard
            puts "#{player.name}, Enter a number (1-9) which is availble"
            choice = gets.chomp.to_i
        end
        choice
    end

    def draw_who_start
        rand(0..1)
    end

    def change_board_sign(player_choice, current_player)
        @@board.each_with_index do |row, idxR|
            row.each_with_index do |column, idxC|
                if(player_choice == column)
                    @@board[idxR][idxC] = current_player.sign
                    @@moveCount += 1
                    current_player.playerChoices.push(column-1)
                end
            end
        end
    end

    def checkWinner(player_choices, current_player)
        if(@@moveCount >= 5)
            @@WIN_INDEX.each_with_index do |row, idxR|
                if(row.all?{|column| player_choices.include?(column)})
                    self.showBoard
                    puts "#{current_player.name.upcase} WIN'S!!!"
                    @@isWinner = true
                    break
                end
            end
            if(@@moveCount == 9 && @@isWinner == false)
                    self.showBoard
                    puts "NO ONE WINS. TIE!!!"
                    @@isWinner = true
            end
        end
    end

end

class Player
    attr_accessor :name, :sign, :playerChoices
    def initialize(name, sign)
        @name = name
        @sign = sign
        @playerChoices = []
    end
end

puts "Player 1 name: "
player1_name = gets.chomp
puts "Player 1 sign, Enter one letter: "
player1_sign = gets.chomp
until (player1_sign.length == 1)
    puts "Player 1 sign, Enter one letter: "
    player1_sign = gets.chomp
end
player1 = Player.new(player1_name, player1_sign)
puts "Player 2 name: "
player2_name = gets.chomp
puts "Player 2 sign, Enter diffrent one letter: \n"
player2_sign = gets.chomp
until (player2_sign.length == 1 && player2_sign != player1_sign)
    puts "Player 2 sign, Enter one letter: "
    player1_sign = gets.chomp
end
player2 = Player.new(player2_name, player2_sign)
game = Game.new(player1, player2)
game.startGame