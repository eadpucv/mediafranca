class SessionsController < ApplicationController
  def new
  	if current_user
  		redirect_to 
  	end
  end
  
  def create
    @citizen = Citizen.authenticate(params[:user][:login], params[:user][:password])    
	respond_to do |format|
		format.xml {
			unless @citizen.blank?
      			session[:citizen_id] = @citizen.id
      			@c_id = @citizen.id
			else
			  	@c_id = "Error"
    		end
		
		} 
		format.html {    
		    @url = params[:url]
    		@url = @url.split("?")
    		@url = @url[0]
			unless @citizen.blank?
      			session[:citizen_id] = @citizen.id
      			redirect_to @url
			else
			  	@url = "#{@url}?error=true"
      			redirect_to @url
    		end
    	}
	end	
    
  end
  
  def destroy
    session[:citizen_id] = nil
    flash[:notice] = t(:goodbye)
    redirect_to root_url
  end
  
  def showForm
  	render(:layout => false)
  end
  
  def hideForm
  	render(:layout => false)
  end
end
