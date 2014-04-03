class PublicationsController < ApplicationController
protect_from_forgery :only => [:new]
require 'time' 

	def new 
        @map = GMap.new("map_div")
        @map.control_init(:small_zoom => true)
        @map.center_zoom_init([-33.0504619,-71.6164515],8)		
	end
	
	def savePoint
		o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;  
		@id  =  (0..50).map{ o[rand(o.length)]  }.join;

		@dir = params[:address]
		@lat = params[:lat]
		@lon = params[:lon]	
		@coordenadas = "#{@lat},#{@lon}"
		
	end
    
    def searchPoint
	  	@map = GMap.new("map_div")
	  	@dir = params[:dir]
	  	@geo=GeoKit::Geocoders::GoogleGeocoder.geocode "#{@dir}"
	  	@lat = @geo.lat 
	  	@long = @geo.lng
	  	@coordenadas = "#{@lat},#{@long}"
		@id = @lat.to_s.split(".")
		@id = @id[1]    	
  
   		@center="map.setCenter(new GLatLng(#{@lat}, #{@long}), 10);"
		@marker = GMarker.new([@lat, @long],:title => "MediaFranca",:draggable => true)
		@map.record_init @marker.on_dragend("gmap_update_position")

    end 
    
    def setNewPoint
    	@lat  = params[:lat]
    	@long = params[:lon]  
    	@res=GeoKit::Geocoders::GoogleGeocoder.reverse_geocode([@lat,@long])
    	@dir= @res.to_s.split("\n")

    	@direccion = @dir[1]
    	@direccion = @direccion.split(":")
    	@direccion = @direccion[1]

    	@ciudad = @dir[2]
    	@ciudad = @ciudad.split(":")
    	@ciudad = @ciudad[1]

    	@region = @dir[3]
    	@region = @region.split(":")
    	@region = @region[1]

    	@dir= "#{@direccion} #{@ciudad} #{@region}"
    end 
    
    
    
    def deletePoint
        @id = params[:id].to_s
    end 

	def create
		@sg = ""
		
		@t = params[:topics]
		@g = params[:positions]
		@m = params[:multimedia]
				
		@conversation = Array.new
		@publication = Publication.new(params[:publication])
		if current_user
			@publication.citizen_id = current_user.id
		end
		@publication.date = Time.now
		@publication.save 
		
		if @t != nil
			for x in @t
			  	@topic = Topic.find(:first,:conditions => ["title = ?", x])

			  	if @topic.nil?
			  		@nt = Topic.new()
			  		@nt.title = x
			  		@nt.save
			  		
			  		@nt4p = PublicationTopics.new()
			  		@nt4p.publication_id = @publication.id 
			  		@nt4p.topic_id = @nt.id 			  		 
			  	else 
			  		@nt4p = PublicationTopics.new()
			  		@nt4p.publication_id = @publication.id 
			  		@nt4p.topic_id = @topic.id 			  		 
			  	end
			  	@nt4p.save
			end
		end  
		
		if @g != nil 
			for g in @g
		  		@p4p = Position.new()
		  		@p4p.citizen_id = @publication.citizen_id
		  		@p4p.publication_id = @publication.id 
		  		@p4p.coordenadas = g
				@p4p.save 			  		 			
			end
		end 
		
		if @m != nil 
			for m in @m
		  		@m4p = Multimedia.new()
		  		@m4p.citizen_id = @publication.citizen_id
		  	 	@m4p.publication_id = @publication.id 

				@m4p.url = m
				@m4p.save 			  		 			
			end
		end 		
				
		respond_to do |format|
			format.xml
			format.html {
				### Parte la sugerencia de cosas
				if params[:topics]
		
					@sg = gimmeSuggest(@t)
					@sg = @sg.sort {|x,y| y[1] <=> x[1]}
					@sg.delete_if {|key, value| value == 0 } 							
				end 
				if params[:type]
					redirect_to :controller => "conversations",:action => 'show', :id => params[:publication][:conversation_id]
				else
					render(:layout => false)
				end
			}
		end			
	end

	def addMultimedia
		@u = params[:url] 
		@mime = params[:mime] 		
		
	end

	def gimmeSuggest(topicsPublication)
		@conversations = {}
		for tp in topicsPublication

			@listConversations = Conversation.all()
			
			for lc in @listConversations
				@conversations[lc.id] = 0			
				@sql = "SELECT distinct topics.title  FROM publications,conversations,publication_topics,topics WHERE publications.conversation_id = #{lc.id} AND publications.id = publication_topics.publication_id AND publication_topics.topic_id = topics.id"
				@t4c = Topic.find_by_sql(@sql)

				for t in @t4c
					if t.title.to_s == tp.to_s
						@conversations[lc.id] += 1
					end				
				end 
			end
		end
			
		return @conversations
	end 

	##########################################
	# Servicios Web
	##########################################
	
	
	##########################################
	## conversations4topicsService
	def conversations4topics
		@conv = Array.new
		@tags = Array.new
		@t = Array.new
		
		if params[:t][:topic]
			## Extraigo las conversaciones sugeridas
			## @sg es un array que tiene [_id, n_de_tags_conincidentes]
			@t = params[:t][:topic]

			@sg = gimmeSuggest(@t)
			@sg = @sg.sort {|x,y| y[1] <=> x[1]}
			@sg.delete_if {|key, value| value == 0 } 							
		
			# por cada _id que tiene @sg, lleno el array @conv, que es finalmente el que se despliega
			for i in 0..@sg.size.to_i - 1 do
				@c = Conversation.first(:conditions => {"_id" => @sg[i][0]})
				@conv << @c
				@conv[i]['tags_coincidentes'] =  @sg[i][1] #cuantas veces esta el topico dentro de una conversacion
	
				@publications = Publication.all(:conditions => {"conversation_id" => @c.id})
				@ultima_publicacion = Publication.first(:conversation_id => @c.id, :order => "time DESC")
				@n_up = Relevance.all(:conditions => {"conversation_id" => @c.id, "tipo" => "up"})
	
				@conv[i]['ultima_publicacion']=@ultima_publicacion.time
				@conv[i]['total_publicaciones']=@publications.size
				@conv[i]['relevance']=@n_up.size
				
				for p in @publications
					for x in p.topics
						unless @tags.include?("#{x}")
							@tags << "#{x}"
						end 
					 end 
				end
				@conv[i]['tags'] = @tags.join(',')
				@conv[i]['tags'] = @conv[i]['tags'].gsub("\n","") 

				@tags.clear			
			end
			#fin de la magia
		end		
	    respond_to do |format| 
	      format.xml 
	    end		 	
	end 


	def anclar2conversation
		@p_id = params[:id_p]
		@c_id = params[:id_c]
		@publication = Publication.first(:conditions => {"id" => @p_id})
		@publication.conversation_id = @c_id
		@publication.save
		
		respond_to do |format| 
			format.xml
	    	format.html {
	    		redirect_to :controller => "conversations",:action => 'show', :id => @c_id
	    	}	
	    end	
		
	end 


end
