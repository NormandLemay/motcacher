require "yaml"
class Grille < ActiveRecord::Base
  after_initialize :init_matrice
  before_save :grid_name

  def display_name
    return "#{name} #{x} X #{y}"
  end

  def get_val_x_y(x,y)
   # Rails.logger.debug"normand get_val_x_y : (#{x} , #{y})"
    return matrice[x][y]
  end

  def build_requete_et_retourne_mot(sense,x,y)

      Rails.logger.debug"normand valeur build_requete_et_retourne_mot : #{x}, #{y}"
    val = ""
    pos_x = x
    pos_y = y
    case sense
      when 0 #horizontal_droite
        (x..9).each do |x|
          val = val + get_val_x_y(x,y)
        end
      when 1 #horizontal_gauche
        (0..pos_x).each do
          val = val + get_val_x_y(x,y)
          x -=1
        end
      when 2 #vertical bas
        (pos_y..9).each do
          val = val + get_val_x_y(x,y)
          y +=1
        end
      when 3 #vertical haut
        (0..pos_y).each do
          val = val + get_val_x_y(x,y)
          y -=1
        end
      when 4 #diagonale_droite_bas
        if x < 8 or y < 8
          (pos_x..(9-pos_y)).each do
            val = val + get_val_x_y(x,y)
            y += 1
            x += 1
          end
        end
      when 5 #diagonale_droite_haut
        if x < 8 or y > 1
          (pos_x..(9-pos_y)).each do
            val = val + get_val_x_y(x,y)
            y -= 1
            x += 1
          end
        end
      when 6 #diagonale_gauche_bas
        (pos_x..9).each do
          val = val + get_val_x_y(x,y)
          y -= 1
          x -= 1
        end
      when 7 #diagonale_gauche_haut
        (pos_x..(10-pos_y)).each do
          val = val + get_val_x_y(x,y)
          y += 1
          x -= 1
        end
      else
        (pos_x..9).each do
          val = val + get_val_x_y(x,y)
          x += 1
        end
    end
    lexique = ""
    lexique = Lexique.find(:first, :conditions => "mot GLOB '#{val}'")#build_requete(sense,x,y))
    lexique = Lexique.find(:first, :conditions => "mot GLOB '#{val.first(val.length-1)}' ") if val.length-1 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "mot GLOB '#{val.first(val.length-2)}' ") if val.length-2 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "mot GLOB '#{val.first(val.length-3)}' ") if val.length-3 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "mot GLOB '#{val.first(val.length-4)}' ") if val.length-4 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "mot GLOB '#{val.first(val.length-5)}' ") if val.length-5 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "mot GLOB '#{val.first(val.length-6)}' ") if val.length-6 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "mot GLOB '#{val.first(val.length-7)}' ") if val.length-7 >=3 and !lexique

    # Rails.logger.debug"normand toto : #{toto}"
 #   Rails.logger.debug"normand build_request : (#{pos_x} , #{pos_y})"
   # condition = "mot GLOB '#{val}' #{toto}"
#"mot GLOB '?a?'"
    if lexique
      Rails.logger.debug"normand valeur de mot : #{lexique.mot}"
      return lexique.mot#condition
    else
      return lexique
    end
  end

  def remplir_grille(prng)
    autre = 0
    begin

      sortir = "n"
      bibi = 0
      begin
        begin
          x = prng.rand(0..7)#9)
          y = prng.rand(0..9)
        end while get_val_x_y(x,y) != "?"
        sense = 5#prng.rand(0..3)#7)
      mot = build_requete_et_retourne_mot(sense,x,y)

        if mot
          sortir = "o"
        elsif bibi >= 150
          sortir = "c"
        end
          bibi += 1
        Rails.logger.debug "normand valeur de bibi : #{bibi} et valeur de sortir : #{sortir}"
      end while sortir == "n"
      if sortir == "o"
          Rails.logger.debug "normand voici le mot a mettre : #{mot}"
        case sense
          when 0
            horizontal_droite(mot,x,y)
          when 1
            horizontal_gauche(mot,x,y)
          when 2
            vertical_bas(mot,x,y)
          when 3
            vertical_haut(mot,x,y)
          when 4
            diagonale_droite_bas(mot,x,y)
          when 5
            diagonale_droite_haut(mot,x,y)
          when 6
            diagonale_gauche_bas(mot,x,y)
          when 7
            diagonale_gauche_haut(mot,x,y)
          else
            horizontal_droite(mot,x,y)
        end

      #  pres = "n"
        matrice.each do |lettre|
          if lettre.include?("?")
            sortir = "o"
          else
            sortir = "c" if sortir != "o"
          end
        end
      end
      if autre >= 30
        sortir = "c"
      end
      autre += 1
         Rails.logger.debug "normand valeur de sortir : #{sortir}"
    end while sortir != "c"
  end

  def horizontal_droite(mot,position_x,position_y)
    mot.each_char do |val|
      Rails.logger.debug"normand valeur de get_val_x_y dans horizontal : #{position_x}, #{position_y}, val #{get_val_x_y(position_x,position_y)}"
      matrice[position_x.to_i][position_y.to_i] = val
      position_x += 1
    end
  end
  def horizontal_gauche(mot,position_x,position_y)
    mot.each_char do |val|
      Rails.logger.debug"normand valeur de get_val_x_y dans horizontal : #{position_x}, #{position_y}, val #{get_val_x_y(position_x,position_y)}"
      matrice[position_x.to_i][position_y.to_i] = val
      position_x -= 1
    end
  end
  def vertical_bas(mot,position_x,position_y)
    mot.each_char do |val|
      matrice[position_x.to_i][position_y.to_i] = val
      position_y += 1
    end
  end

  def vertical_haut(mot,position_x,position_y)
    mot.each_char do |val|
      matrice[position_x.to_i][position_y.to_i] = val
      position_y -= 1
    end
  end

  def diagonale_droite_bas(mot,position_x,position_y)
    if position_x < 8 or position_y < 8
      mot.each_char do |val|
        matrice[position_x.to_i][position_y.to_i] = val
        position_y += 1
        position_x += 1
      end
    end
  end

  def diagonale_droite_haut(mot,position_x,position_y)
    if position_x < 8 or position_y > 1
      mot.each_char do |val|
        matrice[position_x.to_i][position_y.to_i] = val
        position_y -= 1
        position_x += 1
      end
    end
  end

  def diagonale_gauche_bas(mot,position_x,position_y)
    mot.each_char do |x|
      matrice[position_x.to_i][position_y.to_i] = x
      position_y = position_y + 1
      position_x = position_x - 1
    end
  end

  def diagonale_gauche_haut(mot,position_x,position_y)
    mot.each_char do |x|
      matrice[position_x.to_i][position_y.to_i] = x
      position_y = position_y - 1
      position_x = position_x - 1
    end
  end


  protected
  def init_matrice
    @matrice = []
    (1..10).each {@matrice << ["?"] * 10 }
  end

  def matrice
    if self.lettres
      @matrice = rebuild_matrice
    else
      @matrice
    end
    return @matrice
  end

  def grid_name
    self.x ||= 10
    self.y ||= 10
    self.lettres = matrice.to_yaml
  end

  def rebuild_matrice
    return YAML::load(lettres)
  end
end
