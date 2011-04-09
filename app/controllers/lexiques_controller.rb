class LexiquesController < ApplicationController
  # GET /lexiques
  # GET /lexiques.xml
  def index
    @lexiques = Lexique.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lexiques }
    end
  end

  # GET /lexiques/1
  # GET /lexiques/1.xml
  def show
    @lexique = Lexique.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lexique }
    end
  end

  # GET /lexiques/new
  # GET /lexiques/new.xml
  def new
    @lexique = Lexique.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lexique }
    end
  end

  # GET /lexiques/1/edit
  def edit
    @lexique = Lexique.find(params[:id])
  end

  # POST /lexiques
  # POST /lexiques.xml
  def create
    @lexique = Lexique.new(params[:lexique])
#    @lexique1 = Lexique.new
#    @lexique2 = Lexique.new
#    @lexique3 = Lexique.new
#    @lexique4 = Lexique.new
#    @lexique5 = Lexique.new
#    @lexique6 = Lexique.new
#    @lexique7 = Lexique.new
#    @lexique8 = Lexique.new
#    @lexique9 = Lexique.new
#    @lexique11 = Lexique.new
#    @lexique21 = Lexique.new
#    @lexique31 = Lexique.new
#    @lexique41 = Lexique.new
#    @lexique51 = Lexique.new
#    @lexique61 = Lexique.new
#    @lexique71 = Lexique.new
#    @lexique81 = Lexique.new
#    @lexique91 = Lexique.new
#    @lexique1.mot= "opium"
#    @lexique2.mot= "offre"
#    @lexique3.mot= "achat"
#    @lexique4.mot= "negresse"
#    @lexique5.mot= "negre"
#    @lexique6.mot= "naufrage"
#    @lexique7.mot= "mecano"
#    @lexique8.mot= "majeur"
#    @lexique9.mot= "laize"
#    @lexique11.mot= "lache"
#    @lexique21.mot= "tache"
#    @lexique31.mot= "igloo"
#    @lexique41.mot= "inchangee"
#    @lexique51.mot= "humeral"
#    @lexique61.mot= "hagard"
#    @lexique71.mot= "hangard"
#    @lexique81.mot= "genois"
#    @lexique91.mot= "gelif"
    respond_to do |format|
      if @lexique.save #and @lexique1.save and @lexique2.save and @lexique3.save and @lexique4.save and @lexique5.save and
        #  @lexique6.save and @lexique7.save and @lexique8.save and @lexique9.save and @lexique11.save and @lexique21.save and @lexique31.save and @lexique41.save and @lexique51.save and
       #   @lexique61.save and @lexique71.save and @lexique81.save and @lexique91.save
        format.html { redirect_to(@lexique, :notice => 'Lexique was successfully created.') }
        format.xml  { render :xml => @lexique, :status => :created, :location => @lexique }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lexique.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lexiques/1
  # PUT /lexiques/1.xml
  def update
    @lexique = Lexique.find(params[:id])

    respond_to do |format|
      if @lexique.update_attributes(params[:lexique])
        format.html { redirect_to(@lexique, :notice => 'Lexique was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lexique.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lexiques/1
  # DELETE /lexiques/1.xml
  def destroy
    @lexique = Lexique.find(params[:id])
    @lexique.destroy

    respond_to do |format|
      format.html { redirect_to(lexiques_url) }
      format.xml  { head :ok }
    end
  end
end

