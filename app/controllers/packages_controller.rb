class PackagesController < ApplicationController

  before_action :set_package, only: [:show, :edit, :update, :destroy,:requests, :request_makers]
  before_filter :authenticate_user!



  # GET /packages
  # GET /packages.json
  def index
    @packages = Package.authorize_packages_for current_user.id
    respond_to do |format|
      format.html {  }
      format.json { render :json => @packages}
      format.xml  { render :xml =>  @packages.to_xml}
      end
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
    respond_to do |format|
      format.html {  }
      format.json { render :json => @package}
      format.xml  { render :xml =>  @package.to_xml}
      end
  end

  # GET /packages/new
  def new
    @package = Package.new
  end

  # GET /packages/1/edit
  def edit
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)
    @package.user_id = current_user.id

    respond_to do |format|
      if @package.save
        format.html { redirect_to @package, notice: 'Package was successfully created.' }
        format.json { render :show, status: :created, location: @package }
      else
        format.html { render :new }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    respond_to do |format|
      if @package.update(package_params)
        format.html { redirect_to @package, notice: 'Package was successfully updated.' }
        format.json { render :show, status: :ok, location: @package }
      else
        format.html { render :edit }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @package.destroy
    respond_to do |format|
      format.html { redirect_to packages_url, notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @result  = Package.packages_i_can_deliver(current_user.id).near([current_user.latitude,
                                              current_user.longitude], params[:distance] || 1, :units => :km)
    respond_to do |format|
      format.html {  }
      format.json { render :json => @result}
      format.xml  { render :xml =>  @result.to_xml}
      end
end

  def delivered
    @packages = Package.my_delivered_packages current_user.id
    respond_to do |format|
      format.html {  }
      format.json { render :json => @packages}
      format.xml  { render :xml =>  @packages.to_xml}
    end
  end

  def not_delivered
    @packages = Package.my_not_delivered_packages current_user.id
    respond_to do |format|
      format.html {  }
      format.json { render :json => @packages}
      format.xml  { render :xml =>  @packages.to_xml}
    end
  end

  def requests
    @requests = @package.requests
    respond_to do |format|
      format.html {  }
      format.json { render :json => @requests}
      format.xml  { render :xml =>  @requests.to_xml}
    end
  end

  def request_makers
    request = @package.requests

    @makers = request.map{|i| i.user}

    respond_to do |format|
      format.html {  }
      format.json { render :json => @makers}
      format.xml  { render :xml =>  @makers.to_xml}

    end

  end


  private

    def set_package
      if user_signed_in?
        @package =Package.search_package_for_me(current_user.id,params[:id]).first
      end

    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:tittle, :description, :src_lat, :src_lon, :dest_lat, :dest_lon, :delivered, :image)
    end
end
