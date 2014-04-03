class HomeController < ApplicationController

	def indexMap
	 	@map = GMap.new("homeMap")
	    @map.control_init()
        @map.center_zoom_init([-33.0504619,-71.6164515],8) 
        
		@conversations = Conversation.all(:limit => 10)
		@conversations = getDataConversations(@conversations)
		
				
		# solo para generar GEOPUNTOS
		for c in @conversations
			@cor=c.positions.split(';')
			for cor in @cor
				@e = cor.split(',')
				lat=@e[0]
				log=@e[1]				
				zones = GMarker.new([lat,log],:title =>c.title,:info_window => c.title)
				@map.overlay_init(zones)				
			end
		end 
	end
	
	def updateHomeMap

	 	@map = GMap.new("homeMap")
	    @map.control_init()
        @map.center_zoom_init([-33.0504619,-71.6164515],8) 
        
		@id = params[:id]
		@total = params[:total]
		@actual = params[:actual]

		@publications = Publication.find(:all,:conditions=>["conversation_id = ?", @id])		

		 	
	end
	
	def indexList
		@from = params[:tipo]
		@conversations = Array.new 
		
		if (@from=='search')
			@txt = params[:text]
			@c = Conversation.find(:all)
			@res = FALSE
					
			for c in @c
				@sql = "SELECT distinct topics.title  FROM publications,conversations,publication_topics,topics WHERE publications.conversation_id = #{c.id} AND publications.id = publication_topics.publication_id AND publication_topics.topic_id = topics.id"
				@t4c = Topic.find_by_sql(@sql)			
				
				for t in @t4c
					if t.title.to_s.include? @txt
						@res = TRUE
					end
				end 
				
				@publications = Publication.all(:conditions => ["conversation_id = ? AND title LIKE ?",c.id,'%'+@txt+'%'])
				if @publications.size > 0
					@res = TRUE
				end
				
				@titulos = Conversation.find(:all,:conditions=>["title LIKE ?",'%' + @txt+ '%'])
				if @titulos.size > 0
					@res = TRUE
				end
				
				if @res == TRUE
					@conversations << c
				end
				
				@res = FALSE
			end 			
		
			@conversations = getDataConversations(@conversations)				

		else
			@conversations = Conversation.paginate :page => params[:page], :per_page => 5
			@conversations = getDataConversations(@conversations)
		end
	
	
		@t = getPopularTags()
	end


	def seeAll4date
		@conversations = Conversation.paginate :page => params[:page], :per_page => 5
		#agrego data a las conversaciones
		@conversations = getDataConversations(@conversations)	
		@conversations=@conversations.sort!{|a,b| a.ultima_publicacion<=>b.ultima_publicacion}
		@conversations=@conversations.reverse!
		render(:partial=>'seeAllConversations')					
	end

	def seeAll4Publications
		@conversations = Conversation.paginate :page => params[:page], :per_page => 5
		#agrego data a las conversaciones
		@conversations = getDataConversations(@conversations)	
		@conversations=@conversations.sort!{|a,b| a.total_publicaciones<=>b.total_publicaciones}
		@conversations=@conversations.reverse!
		render(:partial=>'seeAllConversations')			
	end 
	
	def seeAll4Relevance
		@conversations = Conversation.paginate :page => params[:page], :per_page => 5
		#agrego data a las conversaciones
		@conversations = getDataConversations(@conversations)	
		@conversations=@conversations.sort!{|a,b| a.relevance<=>b.relevance}
		@conversations=@conversations.reverse!			
		render(:partial=>'seeAllConversations')			
	end


	def getDataConversations(conversations)

		@posis = ""	
		i = 0
		for c in conversations
			@posis = ""
			@xi=0
			
			@sql = "SELECT distinct topics.title  FROM publications,conversations,publication_topics,topics WHERE publications.conversation_id = #{c.id} AND publications.id = publication_topics.publication_id AND publication_topics.topic_id = topics.id"
			@t4c = Topic.find_by_sql(@sql)			
			
			@publications = Publication.all(:conditions => {"conversation_id" => c.id})
			for p in @publications				
				@positions = Position.all(:conditions => {"publication_id" => p.id})
				for x in @positions
					@coor=x.coordenadas.split(',')
					lat=@coor[0]
					log=@coor[1]		
					@posis << "#{lat},#{log};"
				end
			end  			
			conversations[i]['positions'] = @posis
						
			@ultima_publicacion = Publication.first(:conditions => {"conversation_id" => c.id}, :order => "date DESC")
			conversations[i]['ultima_publicacion']=@ultima_publicacion.date
			conversations[i]['total_publicaciones']=@publications.size
			conversations[i]['topics'] = @t4c
			@n_up = Relevance.all(:conditions => {"conversation_id" => c.id, "tipo" => "up"})
			conversations[i]['relevance']=@n_up.size

			if current_user
				@yavoto = Relevance.all(:conditions => {"conversation_id" => c.id, "citizen_id" => current_user.id})
				conversations[i]['ya_voto']=@yavoto.size
			end		
			i = i+1
		end 			
		return conversations
	end 
	
	
	def getPopularTags()

		@sql = "SELECT COUNT(*) AS `Filas`, `topic_id` FROM `publication_topics` GROUP BY `topic_id` ORDER BY `Filas` DESC LIMIT 0 , 10"		
		@tags = Topic.find_by_sql(@sql)

	end 

	
	def topicForConversation(id)
		@tags = Array.new
		@publications = Publication.all(:conditions => {"conversation_id" => id})
		for p in @publications
			for x in p.topics
				unless @tags.include?(x.title)
					@tags << x.title
				end 
			end 
		end 
	end 

	
	def addFilter
		@find = Array.new	
		txt = params[:txt]
		@conversations = Conversation.all      
		for c in @conversations	
			@publications = Publication.first(:conditions => {'topics.title' => [txt], "conversation_id" => c.id})
			unless @publications.blank?
				@find << c 
			end 
		end 
    	render(:layout => false)
	end
end 