class Board < ApplicationRecord
  serialize :squares, Array
  before_create :arranque
  has_many :players, :before_add => :limit_number_of_players

  def limit_number_of_players(added_player)
    raise Exception.new('Límite de jugadores alcanzado') if players.size >= 2
  end

  def arranque
    self.squares = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def stage_one (y)  

    if self.squares[y] == " "
      if self.xTurn == true
        self.squares[y] = "X"
        self.turnNumber = self.turnNumber + 1
        self.check_winner
        self.xTurn = false
      else
        self.squares[y] = "O"
        self.turnNumber = self.turnNumber + 1
        self.check_winner
        self.xTurn = true
      end
    end

  end

  def stage_two (u, y)
   
    if self.squares[y] == " "
      if (self.xTurn == true && self.squares[u] == 'X') || (self.xTurn == false && self.squares[u] == 'O')
        self.squares[u] = " "
        if self.xTurn == true
          self.squares[y] = "X"
          self.check_winner   
          self.xTurn = false      
        else
          self.squares[y] = "O"
          self.check_winner
          self.xTurn = true
        end
      end
      
    end

  end

  def abandon
    if self.winner == false
      self.winner = true
      if self.xTurn == true
        self.xTurn = false
      else
        self.xTurn = true
      end
    end
    return 
  end

  def check_winner
    if self.xTurn == true 
      content = "X"
    else
      content = "O"
    end

    if self.squares[0] == content && self.squares[0] == self.squares[1] && self.squares[0] == self.squares[2]
      self.winner = true
    elsif self.squares[3] == content && self.squares[3] == self.squares[4] && self.squares[3] == self.squares[5]
      self.winner = true
    elsif self.squares[6] == content && self.squares[6] == self.squares[7] && self.squares[6] == self.squares[8]
      self.winner = true
    end

    if self.squares[0] == content && self.squares[0] == self.squares[3] && self.squares[0] == self.squares[6]
      self.winner = true
    elsif self.squares[1] == content && self.squares[1] == self.squares[4] && self.squares[1] == self.squares[7]
      self.winner = true
    elsif self.squares[2] == content && self.squares[2] == self.squares[5] && self.squares[2] == self.squares[8]
      self.winner = true
    end

    if self.squares[0] == content && self.squares[0] == self.squares[4] && self.squares[0] == self.squares[8]
      self.winner = true
    elsif self.squares[2] == content && self.squares[2] == self.squares[4] && self.squares[2] == self.squares[6]
      self.winner = true
    end

  end

end