require 'ar-extensions'
class LocationsController < ApplicationController
before_filter :set_default_response_format
  protected
    def set_default_response_format
      request.format = 'xml'.to_sym if params[:format].nil?
    end

    def get_range(passed_value)
        value = passed_value.to_f
        factor = (value >= 0 ? 0.05 : -0.05)
        value >= 0 ? [value - factor,value + factor] : [value + factor,value - factor]
    end

     # GET /locations
  # GET /locations.xml
  public
  def index
    puts "latitude = #{params[:latitude]}"
    puts "longitude = #{params[:longitude]}"
    puts "userid = #{params[:userid]}"

    lat_range = get_range(params[:latitude])
    long_range = get_range(params[:longitude])
    userid = params[:userid].downcase

    puts "latitude range = #{lat_range}"
    puts "longitude range = #{long_range}"
    #@locations = Location.all
    @locations = Location.find(:all, :conditions => { :latitude_gt => lat_range[0], :latitude_lt => lat_range[1], :longitude_gt => long_range[0], :longitude_lt => long_range[1], :userid_ne => userid})


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.xml
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.xml
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.xml
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        flash[:notice] = 'Location was successfully created.'
        format.html { redirect_to(@location) }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.xml
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        puts "PARAMS = #{params[:location]}"
        @location.latitude = params[:location][:latitude]
        @location.longitude = params[:location][:longitude]
        @location.status = params[:location][:status] || "U"
        @location.points = params[:location][:points]
        @location.udid = params[:location][:udid]
        @location.save
        flash[:notice] = 'Location was successfully updated.'
        format.html { redirect_to(@location) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(locations_url) }
      format.xml  { head :ok }
    end
  end
end
