class GrillesController < ApplicationController
  # GET /grilles
  # GET /grilles.xml
  skip_before_filter :verify_authenticity_token, :only => [:index, :show, :destroy]

  def index
    @grilles = Grille.paginate(:per_page => 20, :page => params[:page])
  end

  # GET /grilles/1
  # GET /grilles/1.xml
  def show
    @grilles = Grille.find(params[:id])
  end

  # GET /grilles/new
  # GET /grilles/new.xml
  def new
    @grille = Grille.new()
  end

  # GET /grilles/1/edit
  def edit
    @grille = Grille.find(params[:id])
  end

  # POST /grilles
  # POST /grilles.xml
  def create
    @grille = Grille.new(params[:grille])
    @grille.y = @grille.x
    prng = Random.new(Time.new.to_i)
    @grille.remplir_grille(prng)
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
#    @grille = Grille.find(params[:id])
#    @grille.destroy
    @grille = Grille.find(params[:id])
    @grille.destroy
    flash[:notice] = "Successfully destroyed product."
    redirect_to grilles_url
#    respond_to do |format|
#      format.html { redirect_to(grilles_url) }
#      format.xml  { head :ok }
#    end
  end
end
