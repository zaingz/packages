class MeController < ApplicationController
  before_filter :authenticate_user!


  def profile
    @current_user_packages= current_user.packages
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => current_user}
      format.xml  { render :xml => current_user.to_xml}
    end
  end


end
