class LookupsController < ApplicationController
  # GET /lookups
  # GET /lookups.json
  def index
    @lookups = Lookup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lookups }
    end
  end

  # GET /lookups/1
  # GET /lookups/1.json
  def show
    @lookup = Lookup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lookup }
    end
  end

  # GET /lookups/new
  # GET /lookups/new.json
  def new
    @lookup = Lookup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lookup }
    end
  end

  # GET /lookups/1/edit
  def edit
    @lookup = Lookup.find(params[:id])
  end

  # POST /lookups
  # POST /lookups.json
  def create
    @lookup = Lookup.new(params[:lookup])

    respond_to do |format|
      if @lookup.save
        format.html { redirect_to @lookup, notice: 'Lookup was successfully created.' }
        format.json { render json: @lookup, status: :created, location: @lookup }
      else
        format.html { render action: "new" }
        format.json { render json: @lookup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lookups/1
  # PUT /lookups/1.json
  def update
    @lookup = Lookup.find(params[:id])

    respond_to do |format|
      if @lookup.update_attributes(params[:lookup])
        format.html { redirect_to @lookup, notice: 'Lookup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lookup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lookups/1
  # DELETE /lookups/1.json
  def destroy
    @lookup = Lookup.find(params[:id])
    @lookup.destroy

    respond_to do |format|
      format.html { redirect_to lookups_url }
      format.json { head :no_content }
    end
  end

  # GET /search?address=foo@example.com&subject=hi there
  def search
    @hits = []
    @dest = "Hello World!"
    @hits.concat(Lookup.where(sorttype: 'A', match: params[:from].downcase))

    # get just the domain into a string
    @domains = params[:from].downcase.gsub(/^.*@/, '')
logger.info @domains
    while !@domains.empty?
      @hits.concat(Lookup.where(sorttype: 'D', match: @domains))
      @domains = @domains.gsub(/^[^\.]*\.?/, '')
logger.info @domains
    end

    # FIXME: look for sorttype "S" also
    #@hits.concat(Lookup.where("? REGEXP match", params[:subject].downcase))

    # Get destination value
    if @hits
      @lookup_value = @hits.pop
      @dest = @lookup_value[:destination]
    else
      @dest = '*DEFAULT'
    end

    # Return JSON to caller
    respond_to do |format|
      format.json { render :json => { :destination => @dest }.to_json }
    end
  end

end
