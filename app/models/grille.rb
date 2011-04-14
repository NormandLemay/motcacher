require "yaml"
class Grille < ActiveRecord::Base
  after_initialize :init_matrice
  before_save :grid_name

  def display_name
    return "#{name} #{x} X #{y}"
  end

  def get_val_x_y(x,y)
    return matrice[x][y]
  end

  def build_requete_et_retourne_mot(sense,x,y)
    val = ""
    pos_x = x
    pos_y = y
    case sense
      when 0 #horizontal_droite
        (x...self.x).each do |x|
          val = val + get_val_x_y(x,y)
        end
      when 1 #horizontal_gauche
        (0..pos_x).each do
          val = val + get_val_x_y(x,y)
          x -=1
        end
      when 2 #vertical bas
        (pos_y...self.x).each do
          val = val + get_val_x_y(x,y)
          y +=1
        end
      when 3 #vertical haut
        (0..pos_y).each do
          val = val + get_val_x_y(x,y)
          y -=1
        end
      when 4 #diagonale_droite_bas
        if x < (self.x-2) or y < (self.x-2)
          (pos_x..((self.x-1)-pos_y)).each do
            val = val + get_val_x_y(x,y)
            y += 1
            x += 1
          end
        end
      when 5 #diagonale_droite_haut
        if x < (self.x-2) or y > 1
          if x + y <= (self.x-1)
            (0..(pos_y)).each do
              val = val + get_val_x_y(x,y)
              y -= 1
              x += 1
            end
          else
            (pos_x...self.x).each do
              val = val + get_val_x_y(x,y)
              y -= 1
              x += 1
            end
          end
        end
      when 6 #diagonale_gauche_bas
        if x > 1 or y < (self.x-2)
          if x + y <= (self.x-1)
            (0..pos_x).each do
              val = val + get_val_x_y(x,y)
              y += 1
              x -= 1
            end
          else
            (pos_y...self.x).each do
              val = val + get_val_x_y(x,y)
              y += 1
              x -= 1
            end
          end
        end
      when 7 #diagonale_gauche_haut
        if x > 1 or y > 1
          if y > x
            (0..pos_x).each do
              val = val + get_val_x_y(x,y)
              y -= 1
              x -= 1
            end
          else
            (0..pos_y).each do
              val = val + get_val_x_y(x,y)
              y -= 1
              x -= 1
            end
          end
        end
      else
        (x...self.x).each do |x|
          val = val + get_val_x_y(x,y)
        end
    end
    lexique = ""
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val}'", :order=>"RANDOM()")
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-1)}' ", :order=>"RANDOM()") if val.length-1 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-2)}' ", :order=>"RANDOM()") if val.length-2 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-3)}' ", :order=>"RANDOM()") if val.length-3 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-4)}' ", :order=>"RANDOM()") if val.length-4 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-5)}' ", :order=>"RANDOM()") if val.length-5 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-6)}' ", :order=>"RANDOM()") if val.length-6 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-7)}' ", :order=>"RANDOM()") if val.length-7 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-8)}' ", :order=>"RANDOM()") if val.length-8 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-9)}' ", :order=>"RANDOM()") if val.length-9 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-10)}' ", :order=>"RANDOM()") if val.length-10 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-11)}' ", :order=>"RANDOM()") if val.length-11 >=3 and !lexique
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and mot GLOB '#{val.first(val.length-12)}' ", :order=>"RANDOM()") if val.length-12 >=3 and !lexique
    @liste_mot = "#{@liste_mot},#{lexique.id}" if lexique
    if lexique
      return lexique.mot
    else
      return lexique
    end
  end

  def remplir_grille(prng)
    autre = 0
    @liste_mot = "0"
    @nbr_lettre_cacher = prng.rand(3...self.x)
    begin

      sortir = "n"
      bibi = 0
      begin
        begin
          x = prng.rand(0...self.x)
          y = prng.rand(0...self.x)
        end while get_val_x_y(x,y) != "?"
        sense = prng.rand(0..7)
        mot = build_requete_et_retourne_mot(sense,x,y)

        if mot
          sortir = "o"
        elsif bibi >= 150
          sortir = "c"
        end
        bibi += 1
      end while sortir == "n"
      if sortir == "o"
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
      end

    @nbr_case_restant  = 0
    matrice.each do |lettres|
      lettres.each do |lettre|
        if lettre.include?("?")
          @nbr_case_restant  += 1
        end
      end
    end
      if autre >= 150 or @nbr_case_restant <= @nbr_lettre_cacher
        sortir = "c"
      end
      autre += 1
    end while sortir != "c"

    mot_cacher

  end

  def mot_cacher
   # Rails.logger.debug "normand mot_cacher nbr_case_restant : #{@nbr_case_restant}"
    nbr_lettre = 0
    lexique = Lexique.find(:first, :conditions => "id not in (#{@liste_mot}) and nbr_lettre ='#{@nbr_case_restant}'", :order=>"RANDOM()")

   # Rails.logger.debug "normand mot cacher: #{lexique.mot}"
    @mot_cache = lexique.id
    (0...self.x).each do |y|
      (0...self.x).each do |x|
        if get_val_x_y(x,y) == "?"
          matrice[x.to_i][y.to_i] = lexique.mot[nbr_lettre]
          nbr_lettre +=1
        end
      end
    end
  end

  def horizontal_droite(mot,position_x,position_y)
    mot.each_char do |val|
      matrice[position_x.to_i][position_y.to_i] = val
      position_x += 1
    end
  end

  def horizontal_gauche(mot,position_x,position_y)
    mot.each_char do |val|
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
    mot.each_char do |val|
      matrice[position_x.to_i][position_y.to_i] = val
      position_y += 1
      position_x += 1
    end
  end

  def diagonale_droite_haut(mot,position_x,position_y)
    mot.each_char do |val|
      matrice[position_x.to_i][position_y.to_i] = val
      position_y -= 1
      position_x += 1
    end
  end

  def diagonale_gauche_bas(mot,position_x,position_y)
    mot.each_char do |val|
      matrice[position_x.to_i][position_y.to_i] = val
      position_y += 1
      position_x -= 1
    end
  end

  def diagonale_gauche_haut(mot,position_x,position_y)
    mot.each_char do |val|
      matrice[position_x.to_i][position_y.to_i] = val
      position_y -= 1
      position_x -= 1
    end
  end


  protected
  def init_matrice
    if self.x
      @matrice = []
      (1..self.x).each {@matrice << ["?"] * self.x }
    end
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
    self.lettres = matrice.to_yaml
    self.listes_mots= @liste_mot
    self.mot_cache=@mot_cache
  end

  def rebuild_matrice
    return YAML::load(lettres)
  end
end
