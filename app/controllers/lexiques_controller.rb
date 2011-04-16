class LexiquesController < ApplicationController
  # GET /lexiques
  # GET /lexiques.xml
  def index
    @lexiques = Lexique.paginate(:per_page => 20, :page => params[:page])
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
    respond_to do |format|
      if @lexique.save
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

