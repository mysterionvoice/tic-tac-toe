class Game 
  LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  attr_reader :available_position

    def initialize
    @board = %w[1 2 3 4 5 6 7 8 9]
    @available_position = [1, 2, 3, 4, 5, 6, 7, 8, 9]
     @players = [
      Player.new(self, 'x', 'Player_1'),
      Player.new(self, 'o', 'Player_2')
    ]
    @current_player = @players[0]
  end
  
  def play
    loop do
      puts "Tic Tac Toe"
      print_board
      user_selection = @current_player.square_selection
      @board[user_selection - 1] = @current_player.mark

      if winner?(@current_player)
        print_board
        puts "#{@current_player.name} wins!"
        exit
      elseif draw?
        print_board
        puts "Draw"
        exit
      end

      switch_player
    end
  end
  
  def print_board
    divider = '--+---+--'
    puts "\n#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts divider
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts divider
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}\n\n"
  end

  def winner?(player)
    LINES.any? do |combination|
      combination.all? { |pos| @board[pos -1] == player.mark }
    end
  end

  def draw?
    @available_position.empty?
  end

  def switch_player
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end
end

class Player
  attr_reader :mark, :name

  def initialize(square, mark, name)
    @square = square
    @mark = mark
    @name = name
  end

  def square_selection
    loop do
      puts "Choose a square, #{@name}:"
      user_selection = gets.chomp.to_i
      if @square.available_position.include?(user_selection)
        return user_selection
      end
      puts "Try again"
    end
  end
end

new_game = Game.new
new_game.play