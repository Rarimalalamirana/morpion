class Player
  attr_accessor :name, :victorious#le nom du joueur et son symbole
  attr_accessor :symbol

  def initialize(name, symbol)
    @name = name
    @victorious = false
    @symbol = symbol
  end

end