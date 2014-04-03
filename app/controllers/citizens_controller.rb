class CitizensController < ApplicationController
before_filter :login_required, :except => [:new,:create]
#  require 'ImageScience'
  def new
    @citizen = Citizen.new
    render(:layout => "citizens" )
  end
  
  def create
    @citizen = Citizen.new(params[:citizen])
    if @citizen.save
      session[:citizen_id] = @citizen.id
      flash[:notice] = t(:newAccount)
      redirect_to :controller=>"home",:action => "indexList"
    else
      render :controller=>"citizen",:action => 'new'
    end
  end

  def edit
    @citizen = Citizen.find(params[:id])
    #@positions = Position.all(:conditions => {:citizen_id => @citizen.id})
    render(:layout => "application" )
  end
  
  def saveImage
  	image = params[:img]
  	@img = Citizen.create(:image => image)
  end 
  
  def update
    @citizen = Citizen.find(params[:citizen][:_id])
    if @citizen.update_attributes(params[:citizen])
      	flash[:notice] = t(:editAccount)
		render (:text => "<span class='tip'>Cambios guardado correctamente</span>")
		
    else
		render (:text => "<span class='error'>Error</span>")
    end
  end
  
  def destroy
    @citizen = Citizen.find(params[:id])
    @citizen.destroy
    flash[:notice] = "Se ha eliminado el usuario correctamente"
    redirect_to :controller =>"citizen", :action =>"todos"
  end
  
  def contacts
    render(:layout => "application" )  	
  end
  
  def uploadImg
	@c = Citizen.find(current_user.id)
  	if Citizen.saveImg(params[:citizen],current_user.id)
  		  Citizen.update(current_user.id, {:name => 'yes'})

		redirect_to :controller =>"citizens", :action =>"edit",:id => current_user.id 
	end 
  end 
  
end
