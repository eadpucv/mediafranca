class RatingController < ApplicationController

	def saveRating
		@p_id = params[:publication_id]
		@tipo = params[:tipo]
		
		@rating= Rating.new
		@rating.citizen_id = params[:citizen_id]
		@rating.publication_id = params[:publication_id]
		@rating.tipo = params[:tipo]
				
		@rating.save
		@nuevoTotalUp = Rating.all(:conditions => {"publication_id" => @p_id, "tipo" => "up"})
		@nuevoTotalDown = Rating.all(:conditions => {"publication_id" => @p_id, "tipo" => "down"})
		@n_up = @nuevoTotalUp.size;
		@n_down = @nuevoTotalDown.size;
	end 

	def getUpRating4Publication
		
	end 

	def getUpRating4Publication
		
	end 	
	
	def userVoteForPublication
	
	end 
	

end
