# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
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

	def topicsForAllConversation
		@tags = Array.new
		@listConversations = Conversation.all()
		for conversation in @listConversations
			@publications = Publication.all(:conditions => {"conversation_id" => conversation.id})
			for p in @publications
				for x in p.topics
					unless @tags.include?(x.title)
						@tags << x.title
					end 
				end 
			end
		end
		return @tags 
	end 	
	
end
