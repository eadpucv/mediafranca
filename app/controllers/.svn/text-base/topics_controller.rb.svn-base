class TopicsController < ApplicationController
require 'set'

  def new
    @topics = Topic.new
  end
    
  def addTopicToPublication
  	@value = ""
  	@t = params[:topic_search]
	#@topicsearch = Topic.all(:conditions => {"title" => "#{@t}"}) #mejorar, solo necesito encontrar 1
	#if @topicsearch.length == 0
	#	@topic = Topic.new(params[:topic])
	#	@topic.save	
	#	@topic_id = @topic.id
	#	
	#else
	#	@topic_id = @topicsearch[0].id
	#end 
	
  end 
  
  def topicSearch
  	@txt = params[:topic_search]
  	if @txt.length >= 3
  		@topics = Topic.find(:all, :conditions => ["title LIKE ?", "%#{@txt}%"])
 	end
	render (:layout => false)
	
  end 
  
  def topicSelected
  end

	
end
