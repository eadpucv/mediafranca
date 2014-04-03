class PositionsController < ApplicationController

	def create
		@position = Position.new(params[:position])
		
		#seteamos variables con los valores pasados por parametros
		@ciudad = params[:position][:ciudad]
		@pais   = params[:position][:pais]
		@direccion = params[:position][:direccion]
		usuario = params[:position][:citizen_id]

		#y rescatamos las coordenadas de la ubicacion
		@citizenPosition= "#{@direccion}, #{@ciudad}, #{@pais}"
		@position.coordenadas = getGeoLocation(@citizenPosition)
		
		puts @position.coordenadas
		#save!
		if @position.save		
  			@positions = Position.all(:conditions => {:citizen_id => current_user.id})
			render(:action =>"listPositions4Citizen", :layout => false)
		else
			render(:text => 'Cago!')
		end
	end 
	
	def getGeoLocation(dir)
		@geo=GeoKit::Geocoders::GoogleGeocoder.geocode "#{dir}"
		@lat = @geo.lat 
		@long = @geo.lng
		@coordenadas = "#{@lat} #{@long}"
		
		return @coordenadas
	end 
	
	
	
	def new
		@position = Position.new
		render(:layout => false)
	end
  
  	def listPositions4Citizen
		render(:layout => false)	
  	end 
  
  	def update
		citizen   = params[:position][:citizen_id]
		
    	@position = Position.find(params[:id])
		@ciudad = params[:position][:ciudad]
		@pais   = params[:position][:pais]

	
		@direccion = params[:position][:direccion]
		@citizenPosition = "#{@direccion}, #{@ciudad}, #{@pais}"

		@position.update_attributes(:coordenadas => getGeoLocation(@citizenPosition))
    	if @position.update_attributes(params[:position])
  			@positions = Position.all(:conditions => {:citizen_id => current_user.id})
      		render(:action =>'listPositions4Citizen', :citizen => citizen, :layout => false)
    	end
  end 
  def edit
    	@position = Position.find(params[:id])
    	render(:layout => false)
  end
  
  def destroy
    	@position = Position.find(params[:id])
    	@position.destroy
    	@notif = "Se ha eliminado la ubicacion correctamente"
		render (:text => @notif)
  end 
end
