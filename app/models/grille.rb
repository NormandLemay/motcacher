require "yaml"
class Grille < ActiveRecord::Base
  after_initialize :init_matrice
  before_save :grid_name
#  def initialize
#    super # appel le initialize du parent
#    matrice = []
#    (1..10).each {matrice << ["_"] * 10 }
#    matrice[2][3] = "x"
#
#  end

#  def trouver_position_vide
#
#
#    return position_x, position_y
#  end
  def display_name
    return "#{name} #{x} X #{y}"
  end

  def get_val_x_y(x,y)
    return matrice[x][y]
  end

  def remplir_grille(prng)
    Rails.logger.debug "normand dans remplir grille :"
    x = prng.rand(0..9)
    y = prng.rand(0..9)
    sense = prng.rand(0..7)
    nbr_lettre = prng.rand(3..10)
    Rails.logger.debug "normand dans la boucle #{x} , #{y}, #{sense}, #{nbr_lettre}"
    Rails.logger.debug "normand remplir_grille : #{matrice}"
    lexique = Lexique.find_by_nbr_lettre(nbr_lettre)
    case sense
      when 0
        horizontal_droite(lexique.mot,x,y)#0,0)
      when 1
        horizontal_gauche(lexique.mot,x,y)#6,1)
      when 2
        vertical_bas(lexique.mot,x,y)#0,2)
      when 3
        vertical_haut(lexique.mot,x,y)#1,6)
      when 4
        diagonale_droite_bas(lexique.mot,x,y)#1,1)
      when 5
        diagonale_droite_haut(lexique.mot,x,y)#4,5)
      when 6
        diagonale_gauche_bas(lexique.mot,x,y)#6,5)
      when 7
        diagonale_gauche_haut(lexique.mot,x,y)#7,9)
      else
        horizontal_droite(lexique.mot,x,y)#0,0)
    end
  end

  def horizontal_droite(mot,position_x,position_y)
    Rails.logger.debug "horizontal_droite : #{matrice}"
    mot.each_char do |x|
      matrice[position_y.to_i][position_x.to_i] = x
      position_x = position_x + 1
    end
  end
  def horizontal_gauche(mot,position_x,position_y)
    Rails.logger.debug "normand horizontal_gauche : #{matrice}"
    mot.each_char do |x|
      matrice[position_y.to_i][position_x.to_i] = x
      position_x = position_x - 1
    end
  end
  def vertical_bas(mot,position_x,position_y)
    Rails.logger.debug "normand vertical_bas : #{matrice}"
    mot.each_char do |x|
      matrice[position_y.to_i][position_x.to_i] = x
      position_y = position_y + 1
    end
  end

  def vertical_haut(mot,position_x,position_y)
    Rails.logger.debug "normand vertical_haut : #{matrice}"
    mot.each_char do |x|
      matrice[position_y.to_i][position_x.to_i] = x
      position_y = position_y - 1
    end
  end

  def diagonale_droite_bas(mot,position_x,position_y)
    Rails.logger.debug "normand diagonale_droite_bas : #{matrice}"
    mot.each_char do |x|
      matrice[position_y.to_i][position_x.to_i] = x
      position_y = position_y + 1
      position_x = position_x + 1
    end
  end

  def diagonale_droite_haut(mot,position_x,position_y)
    Rails.logger.debug "normand diagonale_droite_haut : #{matrice}"
    mot.each_char do |x|
      matrice[position_y.to_i][position_x.to_i] = x
      position_y = position_y - 1
      position_x = position_x + 1
    end
  end

  def diagonale_gauche_bas(mot,position_x,position_y)
    Rails.logger.debug "normand diagonale_gauche_bas : #{matrice}"
    mot.each_char do |x|
      matrice[position_y.to_i][position_x.to_i] = x
      position_y = position_y + 1
      position_x = position_x - 1
    end
  end

  def diagonale_gauche_haut(mot,position_x,position_y)
    Rails.logger.debug "normand diagonale_gauche_haut : #{matrice}"
    mot.each_char do |x|
      matrice[position_y.to_i][position_x.to_i] = x
      position_y = position_y - 1
      position_x = position_x - 1
    end
  end


  protected
  def init_matrice
    if !lettres
      @matrice = []
      (1..10).each {@matrice << ["_"] * 10 }
    end
  end

  def matrice
      if self.lettres
        @matrice = rebuild_matrice
        Rails.logger.debug "normand dans le if: #{@matrice}"
      else
        @matrice
        Rails.logger.debug "normand dans le else : #{@matrice}"
      end
      Rails.logger.debug "normand avant le return : #{@matrice}"
    return @matrice
  end

  def grid_name
    self.x ||= 10
    self.y ||= 10
    self.lettres = @matrice.to_yaml
    Rails.logger.debug"normand dans grid_name : #{self.lettres}"
  end

  def rebuild_matrice
    return YAML::load(lettres)
  end
end
