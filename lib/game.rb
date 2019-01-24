require_relative   'board'
require_relative   'player'

#require_relative 'boardcase'
class Game
 attr_accessor :player_1, :player_2, :board, :playable_cases#LE CURRENT PLAYER,LE STATUS,LE BOARD,ET LE TABLEAU
  def initialize()
    @board = Board.new()
    @playable_cases = ["A1","A2","A3","B1","B2","B3","C1","C2","C3"]#les choix presenter au joueur
  end

  def go
    turn_number = 1 #nombre d tour jouer
    who_plays = 0#on determine qui va jouer
    winner = false#retourne le gagnant et dit false au cas ou il y aura pas de vaiquer
    symbols = ["X", "O"]#on definit le choix du jouer sur le signe
    puts "******************MORPION*********************"
    puts "Joueur n:1,vuiller entrez votre nom !"
    name_1 = gets.chomp
    puts "Joueur n:2,vous aussi entrez votre nom!"
    name_2 = gets.chomp

    puts "#{name_1},Puis choisissez votre symbole (O ou X)"
    symbol_1 = gets.chomp.capitalize#en cas ou les symbole est different du donne il  ya boucle et de meme si le choix est miniscule on l change en maj
    while not ["X", "O"].include?(symbol_1)
      puts "ooohhh! fait le choix entre  X et O!"
      symbol_1 = gets.chomp.capitalize
    end

    symbols.delete(symbol_1)
    symbol_2 = symbols[0]

    @player_1 = Player.new(name_1,symbol_1)
    @player_2 = Player.new(name_2, symbol_2)
# Tant qu'il n'y'a pas de gagnant et qu'il y'a des possibilités de jeux
    puts @board
    while not (winner || @playable_cases.length == 0)
      p @playable_cases.length#le nombre de coup jouer
      winner = turn(who_plays)
      turn_number+=1
      who_plays = (1-who_plays)
    end

    # Mise en forme pour la fin de partie
    if winner
      puts "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
      puts " Felicitation #{winner.name}, vous avez gagné cette partie! "
      puts "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
    else
      puts "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
      puts " Le jeu est terminer  et pas de gagnat  :("
      puts "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
    end

  end

  def turn(number)
    player = [@player_1, @player_2][number]    # TO DO : affiche le plateau, demande au joueur il joue quoi, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
     puts " #{player.name} à vous de jouer! "
    # On force la majuscule pour la saisie
    player_choice = gets.chomp.upcase
    while not @playable_cases.include?(player_choice)    # On boucle si le joueur n'entre pas une case valide
      puts " #{player.name} enter un bon nombre sinon quitter le jeu! "
      puts @playable_cases
      player_choice = gets.chomp.upcase
    end
    @board.put_on_board(player.symbol,player_choice)
    # On supprime des cases disponibles le choix du joueur
    @playable_cases.delete(player_choice)
    puts @board
    # On retourne le coup joué
    return game_over(player)
  end

  # Détermine la fin de la partie
  def game_over(player)
    # Les différentes combinaisons gagnantes
    vic_combi = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    vic_combi.each do |victorious_case|
      # On verifie si 3 symboles du joeur sont dans les cases des combinaisons gagantes
      if @board.board[victorious_case[0]].case_value+ @board.board[victorious_case[1]].case_value+ @board.board[victorious_case[2]].case_value == player.symbol*3
        # On renvoie le joeur s'il a gagné
        return player
      end
    end
    # On retourne false si le joueur n'a pas gagné
    return false
  end
end


Game.new.go