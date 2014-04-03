class RelevanceController < ApplicationController
	def saveRelevance
 
		@p_id = params[:conversation_id]
		@tipo = params[:tipo]
		
		@r = Relevance.new
		@r.citizen_id = params[:citizen_id]
		@r.conversation_id = params[:conversation_id]
		@r.tipo = params[:tipo]
				
		@r.save
		@nuevoTotal = Relevance.all(:conditions => {"conversation_id" => @p_id, "tipo" => @tipo})
		@n = @nuevoTotal.size;
	end 


end
