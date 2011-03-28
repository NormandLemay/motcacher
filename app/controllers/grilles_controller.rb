class GrillesController < ApplicationController
  # GET /grilles
  # GET /grilles.xml

  def index
    @grilles = Grille.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grilles }
    end
  end

  # GET /grilles/1
  # GET /grilles/1.xml
  def show
    @grilles = Grille.find_all_by_numeros(params[:id], :order => 'position_x, position_y desc')

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grille }
    end
  end

  # GET /grilles/new
  # GET /grilles/new.xml
  def new
   # @grille = Grille.new
    prng = Random.new(Time.new.to_i)
    position_x = prng.rand(10)
    position_y = prng.rand(10)
    nombre_lettre = prng.rand(3..10)
    lexique = Lexique.find_by_nbr_lettre(nombre_lettre)

      horizontal_droite(lexique.mot,position_x,position_y)#,@grille)

    @grille = Grille.find_by_numeros(1)


#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @grille }
#    end
  end

  # GET /grilles/1/edit
  def edit
    @grille = Grille.find(params[:id])
  end

  # POST /grilles
  # POST /grilles.xml
  def create
    @grille = Grille.new(params[:grille])

    respond_to do |format|
      if @grille.save
        format.html { redirect_to(@grille, :notice => 'Grille was successfully created.') }
        format.xml  { render :xml => @grille, :status => :created, :location => @grille }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grille.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grilles/1
  # PUT /grilles/1.xml
  def update
    @grille = Grille.find(params[:id])

    respond_to do |format|
      if @grille.update_attributes(params[:grille])
        format.html { redirect_to(@grille, :notice => 'Grille was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grille.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grilles/1
  # DELETE /grilles/1.xml
  def destroy
    @grille = Grille.find(params[:id])
    @grille.destroy

    respond_to do |format|
      format.html { redirect_to(grilles_url) }
      format.xml  { head :ok }
    end
  end

  def horizontal_droite(mot,position_x,position_y)
    mot.each_char do |x|
      grille = Grille.new
      Rails.logger.debug  x
      grille.position_x= position_x.to_i
      grille.position_y= position_y.to_i
      grille.lettre = x
      position_x = position_x + 1
      grille.numeros = 1
      grille.save
    end
  end

  def horizontal_gauche(mot,position_x,position_y, grille)
    mot.each_char do |x|
      Rails.logger.debug  x
      grille.x_y = "#{position_x},#{position_y}"
      grille.lettre = x
      position_x =- 1
    end
  end

  def vertical_bas(mot,position_x,position_y, grille)
    mot.each_char do |x|
      Rails.logger.debug  x
      grille.x_y = "#{position_x},#{position_y}"
      grille.lettre = x
      position_y =- 1
    end
  end

  def vertical_haut(mot,position_x,position_y, grille)
    mot.each_char do |x|
      Rails.logger.debug  x
      grille.x_y = "#{position_x},#{position_y}"
      grille.lettre = x
      position_y =+ 1
    end
  end

  def diagonale_droite_bas(mot,position_x,position_y, grille)
    mot.each_char do |x|
      Rails.logger.debug  x
      grille.x_y = "#{position_x},#{position_y}"
      grille.lettre = x
      position_y =- 1
      position_x =+ 1
    end
  end

  def diagonale_droite_haut(mot,position_x,position_y, grille)
    mot.each_char do |x|
      Rails.logger.debug  x
      grille.x_y = "#{position_x},#{position_y}"
      grille.lettre = x
      position_y =+ 1
      position_x =+ 1
    end
  end

  def diagonale_gauche_bas(mot,position_x,position_y, grille)
    mot.each_char do |x|
      Rails.logger.debug  x
      grille.x_y = "#{position_x},#{position_y}"
      grille.lettre = x
      position_y =- 1
      position_x =- 1
    end
  end

  def diagonale_gauche_haut(mot,position_x,position_y, grille)
    mot.each_char do |x|
      Rails.logger.debug  x
      Rails.logger.debug  position_x
      Rails.logger.debug  position_y
      grille.x_y = "#{position_x},#{position_y}"
      grille.lettre = x
      position_y =+ 1
      position_x =- 1
    end
  end
end
