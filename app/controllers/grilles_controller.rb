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
    @grilles = Grille.find(params[:id])
    # @matrice = @grilles.rebuild_matrice
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grille }
    end
  end

  # GET /grilles/new
  # GET /grilles/new.xml
  def new
    @grille = Grille.new()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grille }
    end
  end

  # GET /grilles/1/edit
  def edit
    @grille = Grille.find(params[:id])
  end

  # POST /grilles
  # POST /grilles.xml
  def create
    @grille = Grille.new(params[:grille])
    @grille.x = 10
    @grille.y = 10
    prng = Random.new(Time.new.to_i)
    (1..5).each do
    @grille.remplir_grille(prng)
    end
#    (1..5).each do
#      prng = Random.new(Time.new.to_i)
#      x = prng.rand(0..9)
#      y = prng.rand(0..9)
#      sense = prng.rand(0..7)
#      nbr_lettre = prng.rand(3..10)
#      Rails.logger.debug "normand dans la boucle #{x} , #{y}, #{sense}, #{nbr_lettre}, #{Time.new.to_i}"
#      lexique = Lexique.find_by_nbr_lettre(5)
#      #@grille.find_sense(nombre_lettre,position_x,position_y)
#      case sense
#        when 0
#          @grille.horizontal_droite(lexique.mot,x,y)#0,0)
#        when 1
#          @grille.horizontal_gauche(lexique.mot,x,y)#6,1)
#        when 2
#          @grille.vertical_bas(lexique.mot,x,y)#0,2)
#        when 3
#          @grille.vertical_haut(lexique.mot,x,y)#1,6)
#        when 4
#          @grille.diagonale_droite_bas(lexique.mot,x,y)#1,1)
#        when 5
#          @grille.diagonale_droite_haut(lexique.mot,x,y)#4,5)
#        when 6
#          @grille.diagonale_gauche_bas(lexique.mot,x,y)#6,5)
#        when 7
#          @grille.diagonale_gauche_haut(lexique.mot,x,y)#7,9)
#        else
#          @grille.horizontal_droite(lexique.mot,x,y)#0,0)
#      end
#    end
#    @grille.horizontal_droite(lexique.mot,0,0)
#    @grille.horizontal_gauche(lexique.mot,6,1)
#    @grille.vertical_bas(lexique.mot,0,2)
#    @grille.vertical_haut(lexique.mot,1,6)
#    @grille.diagonale_droite_bas(lexique.mot,1,1)
#    @grille.diagonale_droite_haut(lexique.mot,4,5)
#    @grille.diagonale_gauche_bas(lexique.mot,6,5)
#    @grille.diagonale_gauche_haut(lexique.mot,7,9)

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
end
