xml.instruct!
xml.conversation do
      xml.title @conversation.title
      xml.tags do
      	
        for t in @tags

	      		xml.tag t
        end
      end
      xml.publications do
      	for p in @publications
      		xml.publication do
				xml.id p.id
				xml.title p.title
				xml.votes_up p.votes_up
				xml.votes_down p.votes_down								
				unless p.topics.blank?
		      		xml.tags do				
				      	for tp in p.topics
				      		xml.tag tp			      	
				      	end
		      		end
	      		end
				unless p.position_id.blank?
		      		xml.positions do
						for x in p.position_id
							xml.coordenada x
						end
					end 		
	      		end	      		
			end
      	end
      end
end