class RequestsController < ApplicationController

  before_action :set_request, only: [:show, :edit, :update, :destroy, :package, :package_owner]
  before_filter :authenticate_user!

  # GET /packages
  # GET /packages.json
  def index
    @requests = Request.authorize_requests_for current_user.id
    respond_to do |format|
      format.html {  }
      format.json { render :json => @requests}
      format.xml  { render :xml =>  @requests.to_xml}
    end
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
    respond_to do |format|
      format.html {  }
      format.json { render :json => @request}
      format.xml  { render :xml =>  @request.to_xml}
    end
  end

  # GET /packages/new
  def new
    @request = Request.new
  end

  # GET /packages/1/edit
  def edit
  end

  # POST /packages
  # POST /packages.json
  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Package was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    respond_to do |format|
      if @request.update(package_params)
        format.html { redirect_to @request, notice: 'Package was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to packages_url, notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def pending
    @requests = Request.my_pending_requests current_user.id
    respond_to do |format|
      format.html {  }
      format.json { render :json => @requests}
      format.xml  { render :xml =>  @requests.to_xml}
      end
  end

  def accepted
    @requests = Request.my_accepted_requests current_user.id
    respond_to do |format|
      format.html {  }
      format.json { render :json => @requests}
      format.xml  { render :xml =>  @requests.to_xml}
      end
  end

  def package
    @package = @request.package
    respond_to do |format|
      format.html {  }
      format.json { render :json => @package}
      format.xml  { render :xml =>  @package.to_xml}
    end
  end

  def package_owner
    @owner = @request.package.user
    respond_to do |format|
      format.html {  }
      format.json { render :json =>@owner}
      format.xml  { render :xml => @owner.to_xml}
    end
  end


  private

  def set_request
    if user_signed_in?
      @request =Request.search_requests_for_me(current_user.id,params[:id]).first
    end
  end


  # make api



  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
   params.require(:request).permit(:message, :package_id)
  end



end
