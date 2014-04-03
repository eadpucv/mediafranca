class ConversationsController < ApplicationController
require 'time' 
	def index 
	end
	
	def getVotes(publications)
		i = 0
		@yavoto=Array.new
		for p in publications
			 @n_up = Rating.all(:conditions => {"publication_id" => p.id, "tipo" => "up"})
			 @n_down = Rating.all(:conditions => {"publication_id" => p.id, "tipo" => "down"})
			 if current_user
			 	@yavoto = Rating.all(:conditions => {"publication_id" => p.id, "citizen_id" => current_user.id})
			 end 
			  
			 publications[i]['votes_up'] = @n_up.size
			 publications[i]['votes_down'] = @n_down.size			 
			 publications[i]['ya_voto'] = @yavoto.size			 			 
			 i = i+1
		end	
		return publications
	end 
	
	def seeAll
		@publications = Publication.all(:conditions => {"conversation_id" => params[:id]})
		@publications = getVotes(@publications)
		render(:partial => "seeAll")
	end 
	
	def seeAll4Date
		@publications = Publication.all(:conditions => {"conversation_id" => params[:id]}, :order=>'date DESC' )
		@publications = getVotes(@publications)
		render(:partial => "seeAll")
	end
	def seeAll4VoteUp
		@publications = Publication.all(:conditions => {"conversation_id" => params[:id]})
		@publications = getVotes(@publications)
		@publications=@publications.sort!{|a,b| a.votes_up<=>b.votes_up}
		@publications=@publications.reverse!
		render(:partial => "seeAll")
	end 	
	def seeAll4VoteDown
		@publications = Publication.all(:conditions=>{"conversation_id" => params[:id]})
		@publications = getVotes(@publications)
		@publications=@publications.sort!{|a,b| a.votes_down<=>b.votes_down}
		@publications=@publications.reverse!
		render(:partial => "seeAll")
	end

	
	def seeOneToOne
		render(:layout => false)
	end 
	
	def seeMedia
		@publications = Publication.all(:conditions => {"conversation_id" => params[:id]})
		@images = Array.new
		for p in @publications
			@multimedia = Multimedia.all(:conditions => {"publication_id" => p.id})
			for x in @multimedia
				@images << x 
			end			
		end 
 	
		render(:layout => false)
	end 
	
	def seePersons
		render(:layout => false)
	end 
	
	def new 
		@map = GMap.new("conversationMap")
		@p_id = params[:p_id]
		render(:layout => false)
	end 
	
	
	
	#Recive un XML con la publicacion
	def createConversationWithPublication
		@conversation = Conversation.new(params[:conversation][:metadata])
		@publication = Publication.new(params[:conversation][:publication])
		@publication.date = Time.now
		@publication.time = Time.now
		@publication.conversation_id = @conversation.id	
		if @publication.save				
			@conversation.first_publication
			@conversation.save
		end 
		respond_to do |format|
			format.xml
			#format.html {redirect_to :controller => "conversations",:action => 'show', :id => @conversation.id}
		end	
	end 



	def createFromForm
		@conversation = Conversation.new(params[:conversation])
		if @conversation.save
			puts "---> #{@conversation.id}"
			@publication = Publication.first(:conditions => {"id" => @conversation.first_publication})
			@publication.conversation_id = @conversation.id
			@publication.citizen_id = @conversation.citizen_id			
			@publication.save		
		end 
		respond_to do |format|
			format.xml
			format.html {redirect_to :controller => "conversations",:action => 'show', :id => @conversation.id}
		end	
	end 
	
	def show
		@map = GMap.new("conversationMap")
		@map2 = GMap.new("conversationMap2")

        @map.control_init(:large_map => true)
        @map.center_zoom_init([-33.0504619,-71.6164515],6)

        @map2.control_init(:large_map => true)
        @map2.center_zoom_init([-33.0504619,-71.6164515],6)
        
        @tags = Array.new

		@publications = Publication.all(:conditions => {"conversation_id" => params[:id]})
		@publications = getVotes(@publications)

		@sql = "SELECT distinct topics.title  FROM publications,conversations,publication_topics,topics WHERE publications.conversation_id = #{params[:id]} AND publications.id = publication_topics.publication_id AND publication_topics.topic_id = topics.id"
		@tags = Topic.find_by_sql(@sql)

		for p in @publications
			@positions = Position.all(:conditions => {"publication_id" => p.id})
			for x in @positions
				@coor=x.coordenadas.split(',')
				lat=@coor[0]
				log=@coor[1]		
				zones = GMarker.new([lat,log],:title =>p.title,:info_window => p.title)
				@map.overlay_init(zones)		
			end
		end
		@conversation = Conversation.find(params[:id])	
		
	    respond_to do |format|
	      format.html #show.html.erb
	      format.xml 
	    end

	end 
    
	def savePoint
		@dir = params[:address]
		@lat = params[:lat]
		@lon = params[:lon]
		@coordenadas = "#{@lat},#{@lon}"
		
	end
    
    def searchPoint
	  	@map = GMap.new("conversationMap2")
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
	
	def search
		@encontrados = Array.new	
		txt = params[:id]
		@conversations = Conversation.all      
		for c in @conversations	
			@publications = Publication.all(:title => Regexp.new("#{txt}"))
			unless @publications.blank?
				@encontrados << c 
			end 
		end 
		
		respond_to do |format|
			format.xml
			format.html {render(:layout => false)}
		end			
    	
	end    


end
